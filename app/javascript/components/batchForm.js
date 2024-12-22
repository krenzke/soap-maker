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
      $(el).select2();
    }
  });

  // hook up the remove button
  if (!removeButton.getAttribute("listenerAttached")) {
    removeButton.addEventListener("click", (e) => {
      e.preventDefault();
      console.log("REMOVING!");
      if (persisted) {
        row.querySelector("input[type=hidden][name$='[_destroy]']").value = "1";
        row.addClass("hidden");
      } else {
        row.remove();
      }
    });
    removeButton.setAttribute("listenerAttached", true);
  }
}

document.addEventListener("DOMContentLoaded", function (event) {
  const addItemButton = document.querySelector("#add-batch-line-item");
  const rowTemplate = document.querySelector("#line-item-template");
  const itemTableBody = document.querySelector("#line-item-table-body");

  itemTableBody.querySelectorAll("tr").forEach((row) => initializeRow(row));

  addItemButton.addEventListener("click", (e) => {
    e.preventDefault();
    const html = rowTemplate.innerHTML.replace(
      /CHILD_INDEX/g,
      new Date().getTime()
    );

    const newRow = $(html).filter("tr").first()[0];

    initializeRow(newRow);
    itemTableBody.append(newRow);

    // itemTableBody.insertAdjacentHTML("beforeend", html);
    // ensureSelect2Initialized(itemTableBody);
    // setSequenceNumbers(itemTableBody);
  });

  setSequenceNumbers(itemTableBody);
});
