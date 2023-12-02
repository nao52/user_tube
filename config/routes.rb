Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  root "static_pages#top"
  get  "/signup", to: "users#new"
  post "/singup/check", to: "users#signup_check"
  get "/login", to: "user_sessions#new"
  post "/login", to: "user_sessions#create"
  delete "/logout", to: "user_sessions#destroy"

  resources :users, only: %i[index show create edit update] do
    collection do
      get :confirm
    end
    member do
      get :contents
    end
  end
  resources :password_resets, only: %i[new create edit update]
end
