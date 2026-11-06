<?php
session_start();
require '../config/db_conn.php';
require 'page-guard.php';
require '../includes/csrf-token.php';
require '../includes/student-promotion-schema.php';

ensureStudentPromotionSchema($conn);

if ($_SERVER['REQUEST_METHOD'] !== 'POST'
    || empty($_SESSION['csrf_token'])
    || !hash_equals($_SESSION['csrf_token'], (string) ($_POST['csrf_token'] ?? ''))) {
    $_SESSION['toast'] = ['message' => 'The retention review request expired. Refresh and try again.', 'type' => 'error'];
    header('Location: student-list.php?view=retention');
    exit;
}

$studentId = trim((string) ($_POST['student_id'] ?? ''));
$action = (string) ($_POST['action'] ?? '');
if ($studentId === '' || !in_array($action, ['approve', 'decline'], true)) {
    $_SESSION['toast'] = ['message' => 'Choose a valid pending retention request.', 'type' => 'error'];
    header('Location: student-list.php?view=retention');
    exit;
}

$setting = $conn->query('SELECT ACTIVE_SCHOOL_YEAR FROM school_year_settings WHERE ID=1')->fetch_assoc();
$schoolYear = (string) ($setting['ACTIVE_SCHOOL_YEAR'] ?? '');
$reviewer = substr(trim((string) ($_SESSION['admin-user'] ?? 'Administrator')), 0, 100) ?: 'Administrator';

try {
    $conn->begin_transaction();
    $pending = $conn->prepare("SELECT s.STUDENT_ID FROM student_retention_requests rq
        JOIN students s ON TRIM(s.STUDENT_ID)=TRIM(rq.STUDENT_ID)
        WHERE rq.STUDENT_ID=? AND rq.SCHOOL_YEAR=? AND rq.STATUS='Pending'
          AND s.ENROLLMENT_STATUS='Enrolled' AND COALESCE(s.IS_ARCHIVED,0)=0
          AND s.GRADE BETWEEN 7 AND 10 FOR UPDATE");
    $pending->bind_param('ss', $studentId, $schoolYear);
    $pending->execute();
    if (!$pending->get_result()->fetch_assoc()) {
        throw new RuntimeException('That retention request is no longer pending or the student is not eligible.');
    }

    $status = $action === 'approve' ? 'Approved' : 'Declined';
    $review = $conn->prepare("UPDATE student_retention_requests
        SET STATUS=?, REVIEWED_BY=?, REVIEWED_AT=NOW()
        WHERE STUDENT_ID=? AND SCHOOL_YEAR=? AND STATUS='Pending'");
    $review->bind_param('ssss', $status, $reviewer, $studentId, $schoolYear);
    $review->execute();
    if ($review->affected_rows !== 1) {
        throw new RuntimeException('The retention request was already reviewed.');
    }

    setStudentRetentionFlag($conn, $studentId, $schoolYear, $action === 'approve');
    $conn->commit();
    $_SESSION['toast'] = ['message' => $action === 'approve'
        ? 'Retention approved. The student will repeat the current grade during rollover.'
        : 'Retention request declined. The student remains eligible for the normal rollover decision.', 'type' => 'success'];
} catch (Throwable $error) {
    $conn->rollback();
    $_SESSION['toast'] = ['message' => $error->getMessage(), 'type' => 'error'];
}

header('Location: student-list.php?view=retention');
exit;
