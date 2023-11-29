Rails.application.routes.draw do
  root "static_pages#top"
  get  "/signup", to: "users#new"
  post "/singup/confirm", to: "users#signup_confirm"
  get "login", to: "user_sessions#new"

  resources :users, only: %i[create] do
    collection do
      get :confirm
    end
  end
  resources :user_sessions, only: %i[create destroy]
end
