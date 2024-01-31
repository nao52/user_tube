document.addEventListener("turbo:load", function() {
  let account_name = document.querySelector("#account-name");
  let hamburger = document.querySelector("#hamburger");

  if (account_name !== null) {
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
  }

  if (hamburger !== null) {
    hamburger.addEventListener("click", function(event) {
      event.preventDefault();

      const navbarMenu = document.querySelector("#navbar-menu");
      const is_menu_visible = navbarMenu.classList.contains("in");

      if (is_menu_visible) {
        navbarMenu.classList.remove("in");
      } else {
        navbarMenu.classList.add("in");
      }
    });
  }
});