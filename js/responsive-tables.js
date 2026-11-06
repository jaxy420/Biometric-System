(() => {
  'use strict';

  const tableSelector = '.overflow-x-auto > table, .table-container > table';

  function headerLabels(table) {
    const rows = table.tHead?.rows;
    const headerRow = rows?.[rows.length - 1];
    if (!headerRow) return [];
    return Array.from(headerRow.cells).map((cell, index) => {
      const label = (cell.textContent || '').replace(/\s+/g, ' ').trim();
      return label || `Detail ${index + 1}`;
    });
  }

  function labelRow(row, labels) {
    if (!row || row.cells.length === 0 || row.querySelector('[colspan]')) return;
    Array.from(row.cells).forEach((cell, index) => {
      if (cell.colSpan > 1) return;
      cell.dataset.label = labels[index] || `Detail ${index + 1}`;
    });
  }

  function prepareTable(table) {
    if (!(table instanceof HTMLTableElement) || table.matches('[data-no-mobile-cards]')) return;
    const labels = headerLabels(table);
    if (!labels.length) return;
    table.dataset.mobileCards = 'true';
    Array.from(table.tBodies).forEach(body => {
      Array.from(body.rows).forEach(row => labelRow(row, labels));
    });
  }

  function prepareAll(scope = document) {
    scope.querySelectorAll?.(tableSelector).forEach(prepareTable);
    if (scope instanceof HTMLTableElement && scope.matches(tableSelector)) prepareTable(scope);
  }

  function watchMutations() {
    const observer = new MutationObserver(mutations => {
      mutations.forEach(mutation => {
        mutation.addedNodes.forEach(node => {
          if (!(node instanceof Element)) return;
          const table = node.closest('table[data-mobile-cards]');
          if (table) {
            const labels = headerLabels(table);
            if (node instanceof HTMLTableRowElement) labelRow(node, labels);
            node.querySelectorAll?.('tr').forEach(row => labelRow(row, labels));
          }
          prepareAll(node);
        });
      });
    });
    observer.observe(document.body, { childList: true, subtree: true });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => { prepareAll(); watchMutations(); }, { once: true });
  } else {
    prepareAll();
    watchMutations();
  }
})();
