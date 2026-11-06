<?php
/**
 * Centralized school-calendar configuration.
 *
 * Attendance rules must never hardcode "Philippine holidays" as the only
 * source of truth. Instead an administrator records the dates that apply to
 * this school: regular school days, holidays, suspensions, approved makeup
 * days, and special schedules.
 *
 * Default rule when a date has no explicit entry:
 *   Monday–Friday  -> school day
 *   Saturday/Sunday -> non-school day
 *
 * Important: a non-school day must never create an absence, and a student is
 * never marked absent merely because they have not scanned.
 */

/** Recognised calendar day types. `school` and `special` count as instructional. */
const SCHOOL_CALENDAR_TYPES = [
    'school',      // regular instructional day
    'special',     // special instructional schedule / approved makeup class
    'holiday',     // official holiday
    'suspension',  // declared class suspension
    'vacation',    // school break / school is out
    'no_class',    // other non-instructional date
];

function ensureSchoolCalendarSchema(mysqli $conn): void
{
    $conn->query(
        "CREATE TABLE IF NOT EXISTS school_calendar (
            CALENDAR_DATE DATE NOT NULL PRIMARY KEY,
            DAY_TYPE VARCHAR(20) NOT NULL DEFAULT 'school',
            LABEL VARCHAR(120) NOT NULL DEFAULT '',
            UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",
    );
}

/** Explicit entry for a date, or null when the default weekday rule applies. */
function schoolCalendarEntry(mysqli $conn, string $date): ?array
{
    $stmt = $conn->prepare(
        'SELECT CALENDAR_DATE, DAY_TYPE, LABEL FROM school_calendar WHERE CALENDAR_DATE=? LIMIT 1',
    );
    $stmt->bind_param('s', $date);
    $stmt->execute();
    $row = $stmt->get_result()->fetch_assoc();
    return $row ?: null;
}

/** True when the date counts for official attendance. */
function isSchoolDay(mysqli $conn, string $date): bool
{
    $entry = schoolCalendarEntry($conn, $date);
    if ($entry) {
        return in_array($entry['DAY_TYPE'], ['school', 'special'], true);
    }
    $timestamp = strtotime($date);
    return $timestamp !== false && (int) date('N', $timestamp) <= 5;
}

/** Structured description used by the UI and reporting. */
function schoolDayInfo(mysqli $conn, string $date): array
{
    $entry = schoolCalendarEntry($conn, $date);
    if ($entry) {
        $type = $entry['DAY_TYPE'];
        $label = (string) $entry['LABEL'];
    } else {
        $timestamp = strtotime($date);
        $type = $timestamp !== false && (int) date('N', $timestamp) <= 5 ? 'school' : 'weekend';
        $label = $type === 'weekend' ? 'Weekend' : '';
    }
    return [
        'date' => $date,
        'type' => $type,
        'label' => $label,
        'is_school_day' => in_array($type, ['school', 'special'], true),
    ];
}

/** Most recent instructional day strictly before $fromDate. */
function previousSchoolDay(mysqli $conn, string $fromDate): string
{
    $timestamp = strtotime($fromDate) ?: time();
    for ($offset = 1; $offset <= 90; $offset++) {
        $candidate = date('Y-m-d', $timestamp - $offset * 86400);
        if (isSchoolDay($conn, $candidate)) {
            return $candidate;
        }
    }
    return date('Y-m-d', $timestamp - 86400);
}

/** Create or update an explicit calendar entry. */
function setSchoolCalendarEntry(mysqli $conn, string $date, string $type, string $label): bool
{
    if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $date)) {
        return false;
    }
    if (!in_array($type, SCHOOL_CALENDAR_TYPES, true)) {
        return false;
    }
    $label = mb_substr(trim($label), 0, 120);
    $stmt = $conn->prepare(
        'INSERT INTO school_calendar (CALENDAR_DATE, DAY_TYPE, LABEL) VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE DAY_TYPE=VALUES(DAY_TYPE), LABEL=VALUES(LABEL)',
    );
    $stmt->bind_param('sss', $date, $type, $label);
    return $stmt->execute() === true;
}

/** Configure every date in an inclusive school-break range as non-instructional. */
function setSchoolVacationRange(mysqli $conn, string $startDate, string $endDate, string $label = ''): bool
{
    $start = DateTimeImmutable::createFromFormat('!Y-m-d', $startDate);
    $end = DateTimeImmutable::createFromFormat('!Y-m-d', $endDate);
    if (!$start || !$end || $start->format('Y-m-d') !== $startDate || $end->format('Y-m-d') !== $endDate || $end < $start) {
        return false;
    }
    if ($start->diff($end)->days > 370) {
        return false;
    }
    $label = trim($label) ?: "School's out / Vacation";
    $conn->begin_transaction();
    try {
        for ($date = $start; $date <= $end; $date = $date->modify('+1 day')) {
            if (!setSchoolCalendarEntry($conn, $date->format('Y-m-d'), 'vacation', $label)) {
                throw new RuntimeException('Could not save the school-break date.');
            }
        }
        $conn->commit();
        return true;
    } catch (Throwable) {
        $conn->rollback();
        return false;
    }
}

/** Remove an explicit entry, reverting the date to the default weekday rule. */
function deleteSchoolCalendarEntry(mysqli $conn, string $date): void
{
    $stmt = $conn->prepare('DELETE FROM school_calendar WHERE CALENDAR_DATE=?');
    $stmt->bind_param('s', $date);
    $stmt->execute();
}

/** Entries within an inclusive range, ordered by date. */
function schoolCalendarEntries(mysqli $conn, string $from, string $to): array
{
    $stmt = $conn->prepare(
        'SELECT CALENDAR_DATE, DAY_TYPE, LABEL FROM school_calendar
          WHERE CALENDAR_DATE BETWEEN ? AND ? ORDER BY CALENDAR_DATE',
    );
    $stmt->bind_param('ss', $from, $to);
    $stmt->execute();
    $result = $stmt->get_result();
    $rows = [];
    while ($row = $result->fetch_assoc()) {
        $rows[] = $row;
    }
    return $rows;
}

/** Human label for a calendar type. */
function schoolCalendarTypeLabel(string $type): string
{
    return match ($type) {
        'school' => 'School day',
        'special' => 'Special / makeup class',
        'holiday' => 'Holiday',
        'suspension' => 'Class suspension',
        'vacation' => "School's out / Vacation",
        'no_class' => 'No class',
        'weekend' => 'Weekend',
        default => ucfirst($type),
    };
}
