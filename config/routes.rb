Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  root "static_pages#top"
  get  "/signup", to: "users#new"
  post "/singup/check", to: "users#signup_check"
  get "/login", to: "user_sessions#new"
  post "/login", to: "user_sessions#create"
  delete "/logout", to: "user_sessions#destroy"

  get 'auth/:provider/callback', to: 'google_login_api#callback'
  get 'auth/failure', to: redirect('/')

  resources :users, only: %i[index show create edit update] do
    get :confirm, on: :collection
    member do
      get :contents, :following, :follower
    end
  end
  resources :password_resets, only: %i[new create edit update]
  resources :relationships, only: %i[create destroy]
end
