function initializeRow(row, beforeRemove) {
  const persisted = row.dataset.persisted === "persisted";
  const removeButton = row.querySelector("[data-remove-button]");
  if (!removeButton) {
    return;
  }

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
      if (persisted) {
        row.querySelector("input[type=hidden][name$='[_destroy]']").value = "1";
        row.classList.add("hidden");
      } else {
        beforeRemove(row);
        row.remove();
      }
    });
    removeButton.setAttribute("listenerAttached", true);
  }
}

export default function initializeDynamicNestedForm({
  tableBodyEl,
  templateEl,
  addButtonEl,
  afterAdd = () => {},
  beforeRemove = () => {},
}) {
  tableBodyEl
    .querySelectorAll("tr")
    .forEach((row) => initializeRow(row, beforeRemove));

  addButtonEl.addEventListener("click", (e) => {
    e.preventDefault();
    const html = templateEl.innerHTML.replace(
      /CHILD_INDEX/g,
      new Date().getTime()
    );

    const newRow = $(html).filter("tr").first()[0];

    initializeRow(newRow, beforeRemove);
    tableBodyEl.append(newRow);
    afterAdd(newRow);
  });
}
