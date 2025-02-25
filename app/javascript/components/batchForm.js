import initializeDynamicNestedForm from "./dynamicNestedForm";

document.addEventListener("DOMContentLoaded", function (event) {
  const addItemButton = document.querySelector("#add-batch-line-item");
  const rowTemplate = document.querySelector("#line-item-template");
  const itemTableBody = document.querySelector("#line-item-table-body");

  if (!addItemButton || !rowTemplate || !itemTableBody) {
    return;
  }

  initializeDynamicNestedForm(itemTableBody, rowTemplate, addItemButton);
});
