<?php
session_start();
if (empty($_SESSION['is-authenticated']) || ($_SESSION['user-role'] ?? '') !== 'administrator') {
    http_response_code(403);
    exit;
}
require_once __DIR__ . '/../includes/student-face-references.php';

$filename = $_GET['file'] ?? '';
if (!is_string($filename) || !in_array($filename, studentFaceDrafts(), true)) {
    http_response_code(404);
    exit;
}
$path = studentFaceDraftDirectory() . $filename;
if (!is_file($path)) {
    http_response_code(404);
    exit;
}
header('Content-Type: ' . (str_ends_with(strtolower($filename), '.png') ? 'image/png' : 'image/jpeg'));
header('Cache-Control: private, no-store');
header('X-Content-Type-Options: nosniff');
readfile($path);
