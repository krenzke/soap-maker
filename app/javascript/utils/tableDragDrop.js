let draggedItems = null;

export default function tableDragDrop(tableBodyEl, onChange = () => {}) {
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
