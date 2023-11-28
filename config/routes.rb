Rails.application.routes.draw do
  root "static_pages#top"
  get  "/signup", to: "users#new"
  post "/singup/confirm", to: "users#confirm"

  resources :users, only: %i[create]
end
