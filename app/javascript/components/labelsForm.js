import initializeDynamicNestedForm from "./dynamicNestedForm";

let draggedItems = null;

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

function setUpDragDropForItems(tableBodyEl, onChange = () => {}) {
  const draggableRows = tableBodyEl.querySelectorAll('tr[draggable="true"]');

  draggableRows.forEach((row) => {
    if (row.getAttribute("dragInitializationComplete")) {
      return;
    }

    let interstitial = row.nextElementSibling;
    if (!interstitial || !interstitial.matches("[data-interstitial=true]")) {
      console.error("Failed to find interstitial element", row);
    }

    row.querySelectorAll("input[type=text]").forEach((input) => {
      input.addEventListener("dragover", (e) => {
        e.preventDefault();
      });
    });

    row.addEventListener("dragstart", (ev) => {
      ev.dataTransfer.setDragImage(row, 0, 0);
      ev.dataTransfer.dropEffect = "move";
      draggedItems = { row, interstitial };
    });

    row.addEventListener("dragend", (ev) => {
      if (draggedItems?.interstitial) {
        draggedItems.interstitial.classList.remove("bg-sky-200");
      }
      draggedItems = null;
    });

    interstitial.addEventListener("drop", (ev) => {
      ev.preventDefault();

      if (!draggedItems) {
        return;
      }

      // drop on self, do nothing
      if (interstitial == draggedItems.interstitial) {
        return;
      }

      interstitial.after(draggedItems.row, draggedItems.interstitial);
      interstitial.classList.remove("bg-sky-200");
      onChange();
    });
    interstitial.addEventListener("dragenter", (ev) => {
      ev.preventDefault();
      interstitial.classList.add("bg-sky-200");
    });
    interstitial.addEventListener("dragleave", (ev) => {
      interstitial.classList.remove("bg-sky-200");
    });
    interstitial.addEventListener("dragover", (ev) => {
      ev.preventDefault();
      ev.dataTransfer.dropEffect = "move";
    });

    row.setAttribute("dragInitializationComplete", true);
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
    setUpDragDropForItems(tableBodyEl, () => setRowSequenceValues(tableBodyEl));
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

  setUpDragDropForItems(tableBodyEl, () => setRowSequenceValues(tableBodyEl));

  setRowSequenceValues(tableBodyEl);
});
