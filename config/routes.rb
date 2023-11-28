Rails.application.routes.draw do
  root "static_pages#top"
  get  "/signup", to: "users#new"
  post "/singup/confirm", to: "users#signup_confirm"

  resources :users, only: %i[create] do
    collection do
      get :confirm
    end
  end
end
