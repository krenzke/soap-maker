function setSequenceNumbers(tableBody) {
  tableBody
    .querySelectorAll("input[type=hidden][name$='[seq]']")
    .forEach((input, i) => {
      input.value = i;
    });
}

function initializeRow(row) {
  const persisted = row.dataset.persisted === "persisted";
  const removeButton = row.querySelector("[data-remove-button]");

  // initialize select2 dropdown
  row.querySelectorAll("[data-use-select2]").forEach((el) => {
    if (!$(el).data("select2")) {
      $(el).select2({ width: "100%" });
    }
  });

  // hook up the remove button
  if (!removeButton.getAttribute("listenerAttached")) {
    removeButton.addEventListener("click", (e) => {
      e.preventDefault();
      console.log("REMOVING!");
      if (persisted) {
        row.querySelector("input[type=hidden][name$='[_destroy]']").value = "1";
        row.classList.add("hidden");
      } else {
        row.remove();
      }
    });
    removeButton.setAttribute("listenerAttached", true);
  }
}

export default function initializeDynamicNestedForm(
  tableEl,
  templateEl,
  addButtonEl
) {
  tableEl.querySelectorAll("tr").forEach((row) => initializeRow(row));

  addButtonEl.addEventListener("click", (e) => {
    e.preventDefault();
    const html = templateEl.innerHTML.replace(
      /CHILD_INDEX/g,
      new Date().getTime()
    );

    const newRow = $(html).filter("tr").first()[0];

    initializeRow(newRow);
    tableEl.append(newRow);
  });

  setSequenceNumbers(tableEl);
}
