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
  const addButtonEl = document.querySelector("#add-batch-line-item");
  const templateEl = document.querySelector("#line-item-template");
  const tableBodyEl = document.querySelector("#line-item-table-body");
  const interstitialTemplateEl = document.querySelector(
    "#line-item-interstitial-template"
  );

  if (!addButtonEl || !templateEl || !tableBodyEl || !interstitialTemplateEl) {
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
    templateEl,
    addButtonEl,
    afterAdd,
    beforeRemove,
  });

  tableDragDrop(tableBodyEl, () => setRowSequenceValues(tableBodyEl));

  setRowSequenceValues(tableBodyEl);
});
