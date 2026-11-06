<?php
require 'page-guard.php';
require '../config/db_conn.php';
require '../includes/teacher-assignment-schema.php';
require '../includes/csrf-token.php';
ensureTeacherAssignmentSchema($conn);
require 'components.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'save_advisories') {
    if (empty($_SESSION['csrf_token']) || !hash_equals($_SESSION['csrf_token'], (string) ($_POST['csrf_token'] ?? ''))) {
        $_SESSION['toast'] = ['message' => 'The advisory request expired. Refresh and try again.', 'type' => 'error'];
    } else {
        try {
            $submitted = $_POST['adviser'] ?? [];
            if (!is_array($submitted)) {
                throw new RuntimeException('Invalid advisory assignments.');
            }
            $conn->begin_transaction();
            replaceTeacherAdvisories($conn, $submitted);
            $conn->commit();
            $_SESSION['toast'] = ['message' => 'Current-year advisory assignments saved.', 'type' => 'success'];
        } catch (Throwable $error) {
            $conn->rollback();
            $_SESSION['toast'] = ['message' => $error instanceof RuntimeException ? $error->getMessage() : 'Advisory assignments could not be saved.', 'type' => 'error'];
        }
    }
    header('Location: advisory-assignments.php');
    exit;
}

$activeSections = $conn->query(
    "SELECT s.SECTION_ID, s.GRADE, s.STRAND, s.SECTION, a.TEACHER_ID
       FROM sections s
       LEFT JOIN current_teacher_advisory_assignments a ON a.SECTION_ID = s.SECTION_ID
      WHERE s.IS_ACTIVE = 1
      ORDER BY s.GRADE, s.STRAND, s.SORT_ORDER, s.SECTION_ID",
)->fetch_all(MYSQLI_ASSOC);
$adviserOptions = $conn->query(
    "SELECT TEACHER_ID, TEACHER_NAME
       FROM teachers
      WHERE COALESCE(NULLIF(TEACHER_STATUS, ''), 'Active') = 'Active'
      ORDER BY TEACHER_NAME",
)->fetch_all(MYSQLI_ASSOC);

adminHead('Post-rollover advisory assignments');
adminSidebar('teachers', 'Post-rollover advisory assignments', 'Assign active teachers to current-year sections.');
?>
<div class="mb-6 flex flex-wrap items-center justify-between gap-3">
    <div>
        <h2 class="text-xl font-black text-slate-900">Post-rollover advisory assignments</h2>
        <p class="mt-1 text-sm text-slate-500">Assign one active teacher per active section. Blank sections remain unassigned; a teacher can appear only once.</p>
    </div>
    <a href="teacher-list.php" class="btn btn-secondary">Back to teachers</a>
</div>

<section class="card card-body">
    <div class="flex items-center justify-between gap-3">
        <h3 class="text-base font-black text-slate-900">Active sections</h3>
        <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-bold text-blue-700"><?= count($activeSections) ?> active sections</span>
    </div>
    <form method="post" class="mt-4 overflow-x-auto">
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($_SESSION['csrf_token']) ?>">
        <input type="hidden" name="action" value="save_advisories">
        <table class="w-full min-w-[34rem] text-left text-sm">
            <thead class="border-b border-slate-200 text-xs uppercase tracking-wide text-slate-500"><tr><th class="p-3">Section</th><th class="p-3">Adviser</th></tr></thead>
            <tbody>
            <?php foreach ($activeSections as $section): ?>
                <tr class="border-b border-slate-100">
                    <td class="p-3 font-bold">Grade <?= (int) $section['GRADE'] ?> · <?= htmlspecialchars($section['SECTION']) ?><?= $section['STRAND'] ? ' · ' . htmlspecialchars($section['STRAND']) : '' ?></td>
                    <td class="p-3">
                        <select name="adviser[<?= (int) $section['SECTION_ID'] ?>]" class="field max-w-sm">
                            <option value="">Unassigned</option>
                            <?php foreach ($adviserOptions as $teacher): ?>
                                <option value="<?= (int) $teacher['TEACHER_ID'] ?>" <?= (int) $section['TEACHER_ID'] === (int) $teacher['TEACHER_ID'] ? 'selected' : '' ?>><?= htmlspecialchars($teacher['TEACHER_NAME']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <button class="btn btn-primary mt-4">Save advisory roster</button>
    </form>
</section>
<?php adminFoot(); ?>
