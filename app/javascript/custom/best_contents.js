document.addEventListener("turbo:load", function() {
  let best_channel_link = document.querySelector("#best-channel-link");
  let best_video_link = document.querySelector("#best-video-link");

  if (best_channel_link === null || best_video_link === null) {
    return
  }

  best_channel_link.addEventListener("click", (event) => {
    event.preventDefault();
    best_channel_link.classList.add("active");
    best_video_link.classList.remove("active");
    document.querySelector(".best-channels").classList.remove("hidden");
    document.querySelector(".best-videos").classList.add("hidden");
  });

  best_video_link.addEventListener("click", (event) => {
    event.preventDefault();
    best_channel_link.classList.remove("active");
    best_video_link.classList.add("active");
    document.querySelector(".best-channels").classList.add("hidden");
    document.querySelector(".best-videos").classList.remove("hidden");
  });
});