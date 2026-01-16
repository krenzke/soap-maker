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

function autofillCostAndUnit(tableRow) {
  const ingredientSelect = tableRow.querySelector(
    "select[name$='[ingredient_id]']"
  );
  const costPerUnitInput = tableRow.querySelector(
    "input[name$='[cost_per_unit]']"
  );
  const unitSelect = tableRow.querySelector("select[name$='[quantity_unit]']");

  const selectedOption =
    ingredientSelect.options[ingredientSelect.selectedIndex];
  costPerUnitInput.value = selectedOption.dataset.defaultCostPerUnit;
  unitSelect.value = selectedOption.dataset.defaultUnit;
}

function initializeSelect2(tableRow) {
  const ingredientSelect = tableRow.querySelector(
    "select[name$='[ingredient_id]']"
  );
  if ($(ingredientSelect).data("select2")) {
    return;
  }
  const costPerUnitInput = tableRow.querySelector(
    "input[name$='[cost_per_unit]']"
  );
  const unitSelect = tableRow.querySelector("select[name$='[quantity_unit]']");

  if (!costPerUnitInput.value) {
    autofillCostAndUnit(tableRow);
  }

  $(ingredientSelect).select2({ width: "100%" });
  $(ingredientSelect).on("change", (e) => {
    autofillCostAndUnit(tableRow);
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
