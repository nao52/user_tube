Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  root "static_pages#top"
  get  "/signup", to: "users#new"
  post "/singup/check", to: "users#signup_check"
  get "/login", to: "user_sessions#new"
  post "/login", to: "user_sessions#create"
  delete "/logout", to: "user_sessions#destroy"
  get "/terms", to: "static_pages#terms"
  get "/privacy", to: "static_pages#privacy"

  get 'auth/:provider/callback', to: 'google_login_api#callback'
  get 'auth/failure', to: redirect('/')

  resources :users, only: %i[index create edit update] do
    get :confirm, on: :collection
    member do
      get :channels, :videos, :contents, :following, :follower, :edit_best
    end
  end
  resources :password_resets, only: %i[new create edit update]
  resources :relationships, only: %i[create destroy]
  resources :channels, only: %i[index show], shallow: true do
    resources :channel_comments, only: %i[new create edit update destroy]
  end
  resources :videos, only: %i[index show], shallow: true do
    resources :video_comments, only: %i[new create edit update destroy]
  end
  resources :contents, shallow: true do
    resources :content_comments, only: %i[new create edit update destroy]
  end
  resources :content_favorites, only: %i[create destroy]
  resources :best_channels_favorites, only: %i[create destroy]
  resource :best_videos, only: %i[edit update]
  resource :best_channels, only: %i[edit update]
  resource :subscription_channels, only: %i[edit update]
  resource :popular_videos, only: %i[edit update]
  resource :recent_content, only: %i[show]
end
