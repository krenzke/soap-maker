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

function autofillCost(tableRow) {
  const ingredientSelect = tableRow.querySelector(
    "select[name$='[ingredient_id]']"
  );
  const costPerGramInput = tableRow.querySelector(
    "input[name$='[cost_per_gram]']"
  );

  const selectedOption =
    ingredientSelect.options[ingredientSelect.selectedIndex];
  costPerGramInput.value = selectedOption.dataset.defaultCostPerGram;
}

function initializeSelect2(tableRow) {
  const ingredientSelect = tableRow.querySelector(
    "select[name$='[ingredient_id]']"
  );
  if ($(ingredientSelect).data("select2")) {
    return;
  }
  const costPerGramInput = tableRow.querySelector(
    "input[name$='[cost_per_gram]']"
  );

  if (!costPerGramInput.value) {
    autofillCost(tableRow);
  }

  $(ingredientSelect).select2({ width: "100%" });
  $(ingredientSelect).on("change", (e) => {
    autofillCost(tableRow);
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

  tableBodyEl
    .querySelectorAll("tr[data-item-row]")
    .forEach((row) => initializeSelect2(row));

  function afterAdd(row) {
    initializeSelect2(row);
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
