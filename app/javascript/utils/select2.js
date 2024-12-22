import jQuery from "jquery";
import select2 from "select2";
import "select2/dist/css/select2.css";
select2();

// define & and jQuery on the global window object
Object.assign(window, { $: jQuery, jQuery });

document.addEventListener("DOMContentLoaded", function (event) {
  document.querySelectorAll("[data-use-select2]").forEach((el) => {
    $(el).select2({ width: "100%" });
  });
});
