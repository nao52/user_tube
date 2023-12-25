document.addEventListener("turbo:load", function() {
  let clear_btn = document.querySelector("#clear-btn");
  if (clear_btn === null) {
    return
  }
  clear_btn.addEventListener("click", () => {
    let input_list = document.querySelectorAll("input.form-control");
    let select_list = document.querySelectorAll("select.form-control");
    input_list.forEach((input) => {
      input.value = null;
    });
    select_list.forEach((select) => {
      select.selectedIndex = 0;
    });
  });
});