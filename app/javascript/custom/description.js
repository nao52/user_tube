document.addEventListener("turbo:load", function() {
  const show_channel_description = document.querySelector("#show-channel-description");

  if (show_channel_description === null) {
    return
  }

  show_channel_description.addEventListener("click", () => {
    const channel_description = document.querySelector(".channel-description p");
    channel_description.classList.toggle("active");
  });
});