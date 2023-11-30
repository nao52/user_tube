Rails.application.routes.draw do
  root "static_pages#top"
  get  "/signup", to: "users#new"
  post "/singup/confirm", to: "users#signup_confirm"
  get "/login", to: "user_sessions#new"
  post "/login", to: "user_sessions#create"
  delete "/logout", to: "user_sessions#destroy"

  resources :users, only: %i[create] do
    collection do
      get :confirm
    end
  end
  resources :password_resets, only: %i[new create edit update]
end
