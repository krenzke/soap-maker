import initializeDynamicNestedForm from "./dynamicNestedForm";
import tableDragDrop from "../utils/tableDragDrop";

function setRowSequenceValues(tableBodyEl) {
  let i = 0;
  tableBodyEl.querySelectorAll("tr").forEach((tr) => {
    const seqInput = tr.querySelector("input[name$='[seq]']");
    if (seqInput) {
      seqInput.value = i;
      i = i + 1;
    }
  });
}

document.addEventListener("DOMContentLoaded", function (event) {
  const tableBodyEl = document.querySelector("#label-line-item-table-body");
  const addButtonEl = document.querySelector("#add-label-line-item");
  const templateEl = document.querySelector("#label-line-item-template");
  const interstitialTemplateEl = document.querySelector(
    "#label-line-item-interstitial-template"
  );

  if (!tableBodyEl || !addButtonEl || !templateEl || !interstitialTemplateEl) {
    return;
  }

  function afterAdd(row) {
    const interstitialRow = $(interstitialTemplateEl.innerHTML)
      .filter("tr")
      .first()[0];
    row.after(interstitialRow);
    tableDragDrop(tableBodyEl, () => setRowSequenceValues(tableBodyEl));
    setRowSequenceValues(tableBodyEl);
  }

  function beforeRemove(row) {
    row.nextElementSibling.remove();
    setRowSequenceValues(tableBodyEl);
  }

  initializeDynamicNestedForm({
    tableBodyEl,
    addButtonEl,
    templateEl,
    afterAdd,
    beforeRemove,
  });

  tableDragDrop(tableBodyEl, () => setRowSequenceValues(tableBodyEl));

  setRowSequenceValues(tableBodyEl);
});
