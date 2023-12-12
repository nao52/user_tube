document.addEventListener("turbo:load", function() {
  let check_public = document.querySelector("#is_public");
  if (check_public === null) {
    return
  }
  check_public.addEventListener("change", (event) => {
    let check_list = document.querySelectorAll(".is_public");
    if (event.currentTarget.checked) {
      for (let i = 0; i < check_list.length; i++) {
        check_list[i].checked = true;
      }
    } else {
      for (let i = 0; i < check_list.length; i++) {
        check_list[i].checked = false;
      }
    }
  });
});