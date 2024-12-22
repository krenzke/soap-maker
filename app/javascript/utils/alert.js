document.addEventListener("DOMContentLoaded", function (event) {
  var alerts = document.querySelectorAll("[data-alert]");
  alerts.forEach((alertEl) => {
    var dismiss = alertEl.querySelector("[data-alert-dismiss]");

    // attach toggle click handler
    if (dismiss) {
      dismiss.onclick = (e) => {
        e.preventDefault();
        alertEl.remove();
      };
    }
  });
});
