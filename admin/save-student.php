<?php
session_start();
require "../config/db_conn.php";
require "page-guard.php";
require '../includes/student-profile-schema.php';
require '../includes/student-placement-options.php';
require '../includes/section-catalog-schema.php';
require '../includes/student-face-references.php';
ensureStudentFaceReferences($conn);
ensureStudentProfileColumns($conn);
ensureSectionCatalogColumns($conn);
seedDefaultTeacherSections($conn);

if(!isset($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']){
    die("Invalid CSRF token.");
}

$submittedText = static function (string $key): string {
    return isset($_POST[$key]) && is_string($_POST[$key]) ? trim($_POST[$key]) : '';
};
$student_id = $submittedText('student_id');
$first_name = $submittedText('first_name');
$middle_name = $submittedText('middle_name');
$last_name = $submittedText('last_name');
$student_name = trim($first_name . ' ' . $middle_name . ' ' . $last_name);
$section = $submittedText('student_section');
$grade = (int)$submittedText('grade');
$age = (int)$submittedText('age');
$strand = $submittedText('strand');
$address = $submittedText('address');

$rememberDraft = static function (array $errors = []) use ($student_id, $first_name, $middle_name, $last_name, $grade, $age, $strand, $section, $address): void {
    unset($_SESSION['student_registration_draft_displayed']);
    $_SESSION['student_registration_draft'] = [
        'student_id' => $student_id,
        'first_name' => $first_name,
        'middle_name' => $middle_name,
        'last_name' => $last_name,
        'grade' => $grade ? (string)$grade : '',
        'age' => $age ? (string)$age : '',
        'strand' => $strand,
        'student_section' => $section,
        'address' => $address,
    ];
    $_SESSION['student_registration_errors'] = $errors;
};

try {
    storeStudentFaceDraftsFromRequest();
} catch (Throwable $error) {
    $rememberDraft();
    $_SESSION['toast'] = ['message' => $error->getMessage(), 'type' => 'error'];
    header('Location: add-student.php');
    exit;
}

$validPlacement = isValidStudentPlacement($grade, $strand, $section) || isApprovedStudentSection($conn, $grade, $strand, $section);
if(empty($student_id) || empty($first_name) || empty($last_name) || !isValidStudentAge($age) || $address==='' || strlen($address)>255 || !$validPlacement){
    $errors = [];
    if ($student_id === '') $errors['student_id'] = 'Enter the student LRN.';
    if ($first_name === '') $errors['first_name'] = 'Enter the first name.';
    if ($last_name === '') $errors['last_name'] = 'Enter the last name.';
    if (!isValidStudentAge($age)) $errors['age'] = 'Enter a valid age.';
    if ($address === '') $errors['address'] = 'Enter the home address.';
    elseif (strlen($address) > 255) $errors['address'] = 'The home address is too long.';
    if (!$validPlacement) $errors['student_section'] = 'Choose a valid grade, strand, and section.';
    $rememberDraft($errors);
    header("Location: add-student.php");
    exit; 
}

// 1. STRICT DUPLICATE CHECK
$checkSql = "SELECT STUDENT_ID FROM students WHERE STUDENT_ID = ?";
$checkStmt = $conn->prepare($checkSql);
$checkStmt->bind_param("s", $student_id);
$checkStmt->execute();
if($checkStmt->get_result()->num_rows > 0) {
    $rememberDraft(['student_id' => 'This LRN is already registered.']);
    header("Location: add-student.php");
    exit; // Stops the script from inserting a duplicate
}

if (!studentSectionHasCapacity($conn, $grade, $strand, $section)) {
    $rememberDraft(['student_section' => studentSectionCapacityMessage($grade, $section)]);
    header('Location: add-student.php');
    exit;
}

// Photos and student details commit together; old photos are never removed.
$prepared = [];
$createdFiles = [];
try {
    $prepared = prepareStudentFaceUploads(true);
    $conn->begin_transaction();
    $db_path = '';
    $sql = "INSERT INTO students (STUDENT_ID, STUDENT_NAME, FIRST_NAME, MIDDLE_NAME, LAST_NAME, GRADE, AGE, STRAND, ADDRESS, SECTION, IMAGE_PATH) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $insert = $conn->prepare($sql);
    $insert->bind_param('sssssiissss', $student_id, $student_name, $first_name, $middle_name, $last_name, $grade, $age, $strand, $address, $section, $db_path);
    $insert->execute();
    saveStudentFaceUploads($conn, (int)$conn->insert_id, $prepared, $createdFiles);
    $conn->commit();
    clearStudentFaceDrafts();
    unset($_SESSION['student_registration_draft'], $_SESSION['student_registration_errors'], $_SESSION['student_registration_draft_displayed']);
    $_SESSION['toast'] = ['message'=>'Registered successfully', 'type'=>'success'];
    $redirect = 'student-list.php';
} catch (Throwable $error) {
    $conn->rollback();
    foreach ($createdFiles as $file) @unlink($file);
    error_log('Student enrollment: ' . $error->getMessage());
    if ($error instanceof mysqli_sql_exception && (int)$error->getCode() === 1062) {
        $rememberDraft(['student_id' => 'This LRN is already registered.']);
    } else {
        $rememberDraft();
        $_SESSION['toast'] = ['message'=>$error instanceof RuntimeException && !($error instanceof mysqli_sql_exception) ? $error->getMessage() : 'The student could not be saved. Please try again.', 'type'=>'error'];
    }
    $redirect = 'add-student.php';
}
cleanupPreparedStudentFaces($prepared);
if ($prepared && ($_SESSION['toast']['type'] ?? '') === 'success') {
    try { $warmed = warmStudentFaceCache($conn); } catch (Throwable $error) { $warmed = false; }
    if (!$warmed) $_SESSION['toast']['message'] .= ' Photos saved; the recognition cache will refresh on the next scan.';
}
header('Location: ' . $redirect);
exit;
