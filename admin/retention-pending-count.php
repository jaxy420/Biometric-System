<?php
session_start();
require '../config/db_conn.php';
require 'page-guard.php';
require '../includes/student-promotion-schema.php';

ensureStudentPromotionSchema($conn);
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store, max-age=0');

$setting = $conn->query('SELECT ACTIVE_SCHOOL_YEAR FROM school_year_settings WHERE ID=1')->fetch_assoc();
$schoolYear = (string) ($setting['ACTIVE_SCHOOL_YEAR'] ?? '');
$count = $conn->prepare("SELECT COUNT(*) AS total
    FROM student_retention_requests rq
    JOIN students s ON TRIM(s.STUDENT_ID)=TRIM(rq.STUDENT_ID)
    WHERE rq.SCHOOL_YEAR=? AND rq.STATUS='Pending'
      AND s.ENROLLMENT_STATUS='Enrolled' AND COALESCE(s.IS_ARCHIVED,0)=0");
$count->bind_param('s', $schoolYear);
$count->execute();
echo json_encode(['pending' => (int) ($count->get_result()->fetch_assoc()['total'] ?? 0)]);
