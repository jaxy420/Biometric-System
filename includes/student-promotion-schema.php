<?php
/** Stores teacher-recorded subject results and the decision made at rollover. */
function ensureStudentPromotionSchema(mysqli $conn): void
{
    $conn->query("CREATE TABLE IF NOT EXISTS student_subject_results (STUDENT_ID VARCHAR(50) NOT NULL, SCHOOL_YEAR VARCHAR(20) NOT NULL, SUBJECT VARCHAR(80) NOT NULL, RESULT VARCHAR(10) NOT NULL, TEACHER_ID INT NOT NULL, GRADE TINYINT UNSIGNED NOT NULL, STRAND VARCHAR(20) NOT NULL DEFAULT '', SECTION VARCHAR(80) NOT NULL, UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY (STUDENT_ID,SCHOOL_YEAR,SUBJECT))");
    $conn->query("CREATE TABLE IF NOT EXISTS student_promotion_decisions (STUDENT_ID VARCHAR(50) NOT NULL, SCHOOL_YEAR VARCHAR(20) NOT NULL, FAILED_SUBJECTS TINYINT UNSIGNED NOT NULL DEFAULT 0, DECISION VARCHAR(40) NOT NULL, IS_RETAINED TINYINT(1) NOT NULL DEFAULT 0, UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY (STUDENT_ID,SCHOOL_YEAR))");
    $conn->query("CREATE TABLE IF NOT EXISTS student_retention_requests (STUDENT_ID VARCHAR(50) NOT NULL, SCHOOL_YEAR VARCHAR(20) NOT NULL, REQUESTED_BY INT NOT NULL, REQUEST_REASON VARCHAR(255) NOT NULL DEFAULT '', STATUS VARCHAR(20) NOT NULL DEFAULT 'Pending', REQUESTED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, REVIEWED_BY VARCHAR(100) NULL DEFAULT NULL, REVIEWED_AT DATETIME NULL DEFAULT NULL, PRIMARY KEY (STUDENT_ID,SCHOOL_YEAR), KEY IDX_RETENTION_REQUEST_STATUS (SCHOOL_YEAR,STATUS))");

    if (!$conn->query("SHOW COLUMNS FROM student_retention_requests LIKE 'REQUEST_REASON'")->num_rows) {
        $conn->query("ALTER TABLE student_retention_requests ADD REQUEST_REASON VARCHAR(255) NOT NULL DEFAULT '' AFTER REQUESTED_BY");
    }

    if (!$conn->query("SHOW COLUMNS FROM student_promotion_decisions LIKE 'IS_RETAINED'")->num_rows) {
        $conn->query("ALTER TABLE student_promotion_decisions ADD IS_RETAINED TINYINT(1) NOT NULL DEFAULT 0 AFTER DECISION");
    }

    // Quarterly grades. Older databases only stored a Passed/Failed RESULT, so
    // these columns are added lazily and leave historical rows untouched.
    $columns = [];
    $columnResult = $conn->query("SHOW COLUMNS FROM student_subject_results");
    while ($columnResult && ($column = $columnResult->fetch_assoc())) {
        $columns[strtoupper((string) $column["Field"])] = true;
    }
    $quarterColumns = [
        "Q1_GRADE" => "DECIMAL(5,2) NULL DEFAULT NULL",
        "Q2_GRADE" => "DECIMAL(5,2) NULL DEFAULT NULL",
        "Q3_GRADE" => "DECIMAL(5,2) NULL DEFAULT NULL",
        "Q4_GRADE" => "DECIMAL(5,2) NULL DEFAULT NULL",
        "FINAL_GRADE" => "DECIMAL(5,2) NULL DEFAULT NULL",
    ];
    foreach ($quarterColumns as $column => $definition) {
        if (!isset($columns[$column])) {
            $conn->query("ALTER TABLE student_subject_results ADD COLUMN {$column} {$definition} AFTER SECTION");
        }
    }
}

/** Retention requests submitted by advisory teachers for the active school year. */
function studentRetentionRequestsByStudent(mysqli $conn, string $schoolYear): array
{
    $stmt = $conn->prepare('SELECT STUDENT_ID,STATUS FROM student_retention_requests WHERE SCHOOL_YEAR=?');
    $stmt->bind_param('s', $schoolYear);
    $stmt->execute();
    $requests = [];
    foreach ($stmt->get_result() as $row) {
        $requests[trim((string) $row['STUDENT_ID'])] = (string) $row['STATUS'];
    }
    return $requests;
}

function submitStudentRetentionRequest(mysqli $conn, string $studentId, string $schoolYear, int $teacherId, string $reason): void
{
    $status = 'Pending';
    $stmt = $conn->prepare("INSERT INTO student_retention_requests (STUDENT_ID,SCHOOL_YEAR,REQUESTED_BY,REQUEST_REASON,STATUS,REQUESTED_AT,REVIEWED_BY,REVIEWED_AT)
        VALUES (?,?,?,?,?,NOW(),NULL,NULL)
        ON DUPLICATE KEY UPDATE REQUESTED_BY=VALUES(REQUESTED_BY),REQUEST_REASON=VALUES(REQUEST_REASON),STATUS='Pending',REQUESTED_AT=NOW(),REVIEWED_BY=NULL,REVIEWED_AT=NULL");
    $stmt->bind_param('ssiss', $studentId, $schoolYear, $teacherId, $reason, $status);
    $stmt->execute();
}

function withdrawStudentRetentionRequest(mysqli $conn, string $studentId, string $schoolYear, int $teacherId): void
{
    $stmt = $conn->prepare("DELETE FROM student_retention_requests
        WHERE STUDENT_ID=? AND SCHOOL_YEAR=? AND REQUESTED_BY=? AND STATUS='Pending'");
    $stmt->bind_param('ssi', $studentId, $schoolYear, $teacherId);
    $stmt->execute();
}

/** Active-year teacher/admin retention decisions, keyed by LRN. */
function studentRetentionFlags(mysqli $conn, string $schoolYear): array
{
    $stmt = $conn->prepare("SELECT STUDENT_ID FROM student_promotion_decisions
        WHERE SCHOOL_YEAR=? AND (IS_RETAINED=1 OR DECISION='Retained')");
    $stmt->bind_param('s', $schoolYear);
    $stmt->execute();
    $flags = [];
    foreach ($stmt->get_result() as $row) $flags[trim((string) $row['STUDENT_ID'])] = true;
    return $flags;
}

/** Persist or clear the explicit current-school-year retention override. */
function setStudentRetentionFlag(mysqli $conn, string $studentId, string $schoolYear, bool $retained): void
{
    if ($retained) {
        $failed = 0;
        $decision = 'Retained';
        $stmt = $conn->prepare("INSERT INTO student_promotion_decisions (STUDENT_ID,SCHOOL_YEAR,FAILED_SUBJECTS,DECISION,IS_RETAINED)
            VALUES (?,?,?,?,1)
            ON DUPLICATE KEY UPDATE DECISION='Retained',IS_RETAINED=1");
        $stmt->bind_param('ssis', $studentId, $schoolYear, $failed, $decision);
        $stmt->execute();
        return;
    }

    // Removing the flag lets the planner recompute the outcome from grades.
    $stmt = $conn->prepare("DELETE FROM student_promotion_decisions
        WHERE STUDENT_ID=? AND SCHOOL_YEAR=? AND (IS_RETAINED=1 OR DECISION='Retained')");
    $stmt->bind_param('ss', $studentId, $schoolYear);
    $stmt->execute();
}

/**
 * Average the quarterly grades that have been entered so far.
 *
 * With all four quarters present this is exactly (Q1 + Q2 + Q3 + Q4) / 4.
 * Partially graded students are averaged over the quarters recorded so far so
 * teachers can still see the running standing of the class.
 */
function studentFinalGrade(array $quarters): ?float
{
    $values = [];
    foreach ($quarters as $grade) {
        if ($grade === null || $grade === "") {
            continue;
        }
        $values[] = (float) $grade;
    }
    if (!$values) {
        return null;
    }
    return round(array_sum($values) / count($values), 2);
}

function studentResultRemark(?float $finalGrade): string
{
    if ($finalGrade === null) {
        return "";
    }
    return $finalGrade >= 75 ? "Passed" : "Failed";
}

function studentPromotionDecision(int $failedSubjects): string
{
    // Retention is an explicit administrative override. A failing final grade
    // creates a remedial obligation but does not silently keep a student back.
    if ($failedSubjects >= 1) return 'Summer Class / Remedial';
    return 'Promoted';
}
