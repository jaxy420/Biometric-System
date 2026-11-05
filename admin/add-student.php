<?php
session_start();
require "../config/db_conn.php";
require "../includes/csrf-token.php";
require "../includes/student-placement-options.php";
require "../includes/section-catalog-schema.php";
require "page-guard.php";
require "components.php";
require_once "../includes/student-face-references.php";
ensureStudentFaceReferences($conn);
ensureSectionCatalogColumns($conn);
seedDefaultTeacherSections($conn);
$toast = $_SESSION["toast"]["message"] ?? null;
unset($_SESSION["toast"]);
// A failed registration returns one recoverable copy of the form. Refreshing
// the page deliberately starts a clean registration instead of retaining it.
if (!empty($_SESSION['student_registration_draft_displayed'])) {
    clearStudentFaceDrafts();
    unset(
        $_SESSION['student_registration_draft'],
        $_SESSION['student_registration_errors'],
        $_SESSION['student_registration_draft_displayed'],
    );
    $draft = [];
    $fieldErrors = [];
} else {
    $draft = $_SESSION['student_registration_draft'] ?? [];
    $fieldErrors = $_SESSION['student_registration_errors'] ?? [];
    unset($_SESSION['student_registration_errors']);
    if ($draft || studentFaceDrafts()) $_SESSION['student_registration_draft_displayed'] = true;
}
$old = static fn(string $field): string => htmlspecialchars((string)($draft[$field] ?? ''), ENT_QUOTES);
$fieldClass = static function (string $field) use ($fieldErrors): string {
    return 'mt-2 w-full rounded-xl border px-4 py-3 outline-none focus:ring-4 ' .
        (isset($fieldErrors[$field])
            ? 'border-rose-500 focus:border-rose-600 focus:ring-rose-100'
            : 'border-slate-300 focus:border-blue-600 focus:ring-blue-100');
};
adminHead("Register student");
adminSidebar(
    "students",
    "Register student",
    "Create a student profile for attendance recognition",
);
?>
<div class="w-full">
    <a href="student-list.php" class="mb-4 inline-flex items-center gap-2 rounded-xl border border-slate-300 bg-white px-4 py-2 text-sm font-bold text-slate-700 shadow-sm transition hover:bg-slate-50 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800">← Back to students</a>
    <section class="card card-body">
        <p class="text-sm font-bold uppercase tracking-widest text-blue-600">Student profile</p>
        <h2 class="mt-2 text-2xl font-black text-slate-900">Registration details</h2>
        <p class="mt-2 text-slate-500">All fields marked below are required.</p>
        <form action="save-student.php" method="post" enctype="multipart/form-data" class="mt-7 space-y-5">
            <input type="hidden" name="csrf_token" value="<?= htmlspecialchars(
                $_SESSION["csrf_token"],
            ) ?>">
            <div class="grid gap-5 sm:grid-cols-2">
                <label class="block text-sm font-bold text-slate-700">LRN<input
                        class="<?= $fieldClass('student_id') ?>"
                        name="student_id" value="<?= $old('student_id') ?>" placeholder="e.g. 2024-0001" required><?php if (isset($fieldErrors['student_id'])): ?><p class="mt-2 text-xs font-semibold text-rose-600"><?= htmlspecialchars($fieldErrors['student_id']) ?></p><?php endif; ?></label>
                <label class="block text-sm font-bold text-slate-700">Grade<select
                        class="<?= $fieldClass('student_section') ?> bg-white"
                        name="grade" onchange="window.updateStudentPlacement && window.updateStudentPlacement()" required>
                        <option value="">Choose a grade</option><?php foreach (
                    [7, 8, 9, 10, 11, 12]
                    as $grade
                ): ?><option value="<?= $grade ?>"<?= $old('grade') === (string)$grade ? ' selected' : '' ?>>Grade <?= $grade ?></option><?php endforeach; ?>
                    </select><?php if (isset($fieldErrors['student_section'])): ?><p class="mt-2 text-xs font-semibold text-rose-600"><?= htmlspecialchars($fieldErrors['student_section']) ?></p><?php endif; ?></label>
            </div>
            <div class="grid gap-5 sm:grid-cols-2">
                <label id="strand-field" class="hidden text-sm font-bold text-slate-700">Strand<select
                        id="student-strand"
                        class="<?= $fieldClass('student_section') ?> bg-white"
                        name="strand" onchange="window.updateStudentSeniorSections && window.updateStudentSeniorSections()" disabled>
                        <option value="">Choose a strand</option>
                    </select></label>
                <label id="section-field" class="block text-sm font-bold text-slate-700 sm:col-span-2">Section<select
                        id="student-section"
                        class="<?= $fieldClass('student_section') ?> bg-white"
                        name="student_section" required disabled>
                        <option value="">Choose a grade first</option>
                    </select></label>
            </div>
            <div class="grid gap-5 sm:grid-cols-3"><label class="block text-sm font-bold text-slate-700">First
                    name<input
                        class="<?= $fieldClass('first_name') ?>"
                        name="first_name" value="<?= $old('first_name') ?>" autocomplete="given-name" required><?php if (isset($fieldErrors['first_name'])): ?><p class="mt-2 text-xs font-semibold text-rose-600"><?= htmlspecialchars($fieldErrors['first_name']) ?></p><?php endif; ?></label><label
                    class="block text-sm font-bold text-slate-700">Middle name<input
                        class="mt-2 w-full rounded-xl border border-slate-300 px-4 py-3 outline-none focus:border-blue-600 focus:ring-4 focus:ring-blue-100"
                        name="middle_name" value="<?= $old('middle_name') ?>" autocomplete="additional-name"></label><label
                    class="block text-sm font-bold text-slate-700">Last name<input
                        class="<?= $fieldClass('last_name') ?>"
                        name="last_name" value="<?= $old('last_name') ?>" autocomplete="family-name" required><?php if (isset($fieldErrors['last_name'])): ?><p class="mt-2 text-xs font-semibold text-rose-600"><?= htmlspecialchars($fieldErrors['last_name']) ?></p><?php endif; ?></label></div>
            <div class="grid gap-5 sm:grid-cols-[140px_minmax(0,1fr)]"><label
                    class="block text-sm font-bold text-slate-700">Age<input
                        class="<?= $fieldClass('age') ?>"
                        type="number" name="age" value="<?= $old('age') ?>" min="3" max="120" inputmode="numeric" required><?php if (isset($fieldErrors['age'])): ?><p class="mt-2 text-xs font-semibold text-rose-600"><?= htmlspecialchars($fieldErrors['age']) ?></p><?php endif; ?></label><label
                    class="block text-sm font-bold text-slate-700">Home address<input
                        class="<?= $fieldClass('address') ?>"
                        name="address" value="<?= $old('address') ?>" autocomplete="street-address" maxlength="255" required><?php if (isset($fieldErrors['address'])): ?><p class="mt-2 text-xs font-semibold text-rose-600"><?= htmlspecialchars($fieldErrors['address']) ?></p><?php endif; ?></label></div>
            <?php require "../includes/student-face-fields.php"; ?>
            <button
                class="btn btn-primary w-full">Register
                student</button>
        </form>
    </section>
</div>
<?php if (
    $toast
): ?><div data-auto-toast
    class="fixed bottom-5 right-5 rounded-xl bg-slate-900 px-5 py-4 font-semibold text-white shadow-xl transition-all duration-300"><?= htmlspecialchars(
    $toast,
) ?></div><?php endif; ?>
<script>
    const placementOptions = <?php echo json_encode(
        studentSectionPlacementOptions($conn),
        JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT,
    ); ?>;
    const savedStudentDraft = <?= json_encode($draft, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT) ?>;
    let restoringSavedPlacement = Boolean(savedStudentDraft.grade && savedStudentDraft.student_section);
    const gradeSelect = document.querySelector('[name="grade"]'),
        sectionSelect = document.getElementById('student-section'),
        strandSelect = document.getElementById('student-strand'),
        sectionField = document.getElementById('section-field'),
        strandField = document.getElementById('strand-field');

    function setOptions(select, placeholder, items) {
        select.innerHTML = '';
        const first = document.createElement('option');
        first.value = '';
        first.textContent = placeholder;
        select.appendChild(first);
        items.forEach(item => {
            const option = document.createElement('option');
            option.value = item;
            option.textContent = item;
            select.appendChild(option)
        })
    }

    function sectionsFor(grade, strand = '') {
        const configured = grade === '11' || grade === '12'
            ? (placementOptions[grade]?.[strand] || [])
            : (placementOptions[grade] || []);
        const sections = Array.isArray(configured) ? [...configured] : [];
        const isSavedPlacement = restoringSavedPlacement &&
            String(savedStudentDraft.grade || '') === String(grade) &&
            String(savedStudentDraft.strand || '') === String(strand);
        if (isSavedPlacement && savedStudentDraft.student_section && !sections.includes(savedStudentDraft.student_section)) {
            sections.push(savedStudentDraft.student_section);
        }
        return sections;
    }

    function updatePlacement() {
        const grade = gradeSelect.value,
            senior = grade === '11' || grade === '12';
        strandField.classList.toggle('hidden', !senior);
        strandSelect.disabled = !senior;
        strandSelect.required = senior;
        sectionField.classList.toggle('sm:col-span-2', !senior);
        if (!grade) {
            setOptions(sectionSelect, 'Choose a grade first', []);
            sectionSelect.disabled = true;
            setOptions(strandSelect, 'Choose a strand', []);
            return
        }
        if (!senior) {
            strandSelect.value = '';
            setOptions(sectionSelect, 'Choose a section', sectionsFor(grade));
            sectionSelect.disabled = false;
            return
        }
        setOptions(strandSelect, 'Choose a strand', ['Techpro', 'Academic']);
        setOptions(sectionSelect, 'Choose a strand first', []);
        sectionSelect.disabled = true
    }

    function updateSeniorSections() {
        if (!(gradeSelect.value === '11' || gradeSelect.value === '12')) return;
        const sections = sectionsFor(gradeSelect.value, strandSelect.value);
        setOptions(sectionSelect, strandSelect.value ? 'Choose a section' : 'Choose a strand first', sections);
        sectionSelect.disabled = !strandSelect.value
    }
    // Expose the filters for the native select onchange handlers as a
    // fallback when a browser drops an addEventListener change event.
    window.updateStudentPlacement = updatePlacement;
    window.updateStudentSeniorSections = updateSeniorSections;
    gradeSelect.addEventListener('change', updatePlacement);
    gradeSelect.addEventListener('input', updatePlacement);
    strandSelect.addEventListener('change', updateSeniorSections);
    strandSelect.addEventListener('input', updateSeniorSections);
    function restoreSavedPlacement() {
        if (savedStudentDraft.grade) gradeSelect.value = savedStudentDraft.grade;
        updatePlacement();
        if (savedStudentDraft.strand) {
            strandSelect.value = savedStudentDraft.strand;
            updateSeniorSections();
        }
        if (savedStudentDraft.student_section) sectionSelect.value = savedStudentDraft.student_section;
    }
    restoreSavedPlacement();
    restoringSavedPlacement = false;
    // Some browsers restore a select value after scripts have run and do not
    // fire change. Rebuild Section from the value currently visible in Grade.
    const synchronizeVisiblePlacement = () => {
        const currentGrade = gradeSelect.value;
        const currentStrand = strandSelect.value;
        const currentSection = sectionSelect.value;
        if (!currentGrade) return;
        updatePlacement();
        if ((currentGrade === '11' || currentGrade === '12') && currentStrand) {
            strandSelect.value = currentStrand;
            updateSeniorSections();
        }
        if (currentSection) sectionSelect.value = currentSection;
    };
    // Retry briefly after load/pageshow for browser form restoration, without
    // overwriting a recovered duplicate-registration draft.
    [0, 150, 500, 1000, 1800].forEach(delay => {
        window.setTimeout(synchronizeVisiblePlacement, delay);
    });
    window.addEventListener('pageshow', synchronizeVisiblePlacement);
    sectionSelect.addEventListener('pointerdown', () => {
        if (gradeSelect.value && sectionSelect.disabled) {
            updatePlacement();
            if (strandSelect.value) updateSeniorSections();
        }
    });
</script>
<?php adminFoot(); ?>
