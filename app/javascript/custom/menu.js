document.addEventListener("turbo:load", function() {
  let account_name = document.querySelector("#account-name");
  if (account_name === null) {
    return
  }
  account_name.addEventListener("click", function(event) {
    event.preventDefault();
    let menu = document.querySelector("#dropdown-menu");
    menu.classList.toggle("active");
    document.addEventListener("click", function(event) {
      if(event.target.closest('#dropdown') === null) {
        menu.classList.remove("active");
      }
    });
  });
});