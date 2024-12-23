document.addEventListener("DOMContentLoaded", function (event) {
  const gallery = [
    ...document.querySelectorAll("[data-batch-gallery-link]"),
  ].map((link, index) => {
    const id = link.dataset.batchGalleryLink;
    const dialog = document.querySelector(`dialog[data-image-dialog='${id}']`);

    link.addEventListener("click", (e) => {
      e.preventDefault();
      dialog.showPopover();
    });

    dialog.addEventListener("keydown", (e) => {
      if (e.key === "ArrowRight" || e.key === "ArrowLeft") {
        const offset = e.key === "ArrowRight" ? 1 : -1;
        let nextIndex = index + offset;
        if (nextIndex < 0) {
          nextIndex += gallery.length;
        }
        nextIndex = nextIndex % gallery.length;
        gallery[nextIndex].dialog.showPopover();
      }
    });

    return {
      link,
      dialog,
    };
  });
});
