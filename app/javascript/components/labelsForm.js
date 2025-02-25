import initializeDynamicNestedForm from "./dynamicNestedForm";

document.addEventListener("DOMContentLoaded", function (event) {
  const addItemButton = document.querySelector("#add-label-line-item");
  const rowTemplate = document.querySelector("#label-line-item-template");
  const itemTableBody = document.querySelector("#label-line-item-table-body");

  if (!addItemButton || !rowTemplate || !itemTableBody) {
    return;
  }

  initializeDynamicNestedForm(itemTableBody, rowTemplate, addItemButton);
});
