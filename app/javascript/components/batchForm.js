import initializeDynamicNestedForm from "./dynamicNestedForm";

document.addEventListener("DOMContentLoaded", function (event) {
  const addButtonEl = document.querySelector("#add-batch-line-item");
  const templateEl = document.querySelector("#line-item-template");
  const tableBodyEl = document.querySelector("#line-item-table-body");

  if (!addButtonEl || !templateEl || !tableBodyEl) {
    return;
  }

  initializeDynamicNestedForm({ tableBodyEl, templateEl, addButtonEl });
});
