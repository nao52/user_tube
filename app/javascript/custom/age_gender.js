document.addEventListener("turbo:load", () => {
  const select_age = document.querySelector("#edit_users_form_age");
  const select_gender = document.querySelector("#edit_users_form_gender");

  if (select_age === null || select_gender === null) {
    return
  }

  change_permission_age_is_public(select_age);
  change_permission_gender_is_public(select_gender);

  select_age.addEventListener("change", (e) => {
    change_permission_age_is_public(e.target);
  });

  select_gender.addEventListener("change", (e) => {
    change_permission_gender_is_public(e.target);
  }); 
});

const change_permission_age_is_public = (target) => {
  const target_value = target.value;
  const age_is_public = document.querySelector("#edit_users_form_age_is_public");
  if (target_value === '') {
    age_is_public.checked = false;
    age_is_public.disabled = true;
  } else {
    age_is_public.disabled = false;
  }
}

const change_permission_gender_is_public = (target) => {
  const target_value = target.value;
  const gender_is_public = document.querySelector("#edit_users_form_gender_is_public");
  if (target_value === 'not_known') {
    gender_is_public.checked = false;
    gender_is_public.disabled = true;
  } else {
    gender_is_public.disabled = false;
  }
}