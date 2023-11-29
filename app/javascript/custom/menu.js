document.addEventListener("turbo:load", function() {
  let account_name = document.querySelector("#account-name");
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