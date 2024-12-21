document.addEventListener("DOMContentLoaded", function (event) {
  var forms = document.querySelectorAll("form[data-confirm]");
  forms.forEach((formEl) => {
    var msg = formEl.dataset.confirm;

    // attach submit handler
    formEl.onsubmit = (e) => {
      e.preventDefault();
      if (confirm(msg)) {
        formEl.submit();
      }
    };
  });
});
