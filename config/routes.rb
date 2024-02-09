Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  root "static_pages#top"
  get "/privacypolicy", to: "static_pages#privacypolicy"
  get "/terms", to: "static_pages#terms"
  get "/login", to: "user_sessions#new"
  delete "/logout", to: "user_sessions#destroy"
  
  get 'auth/:provider/callback', to: "user_sessions#create"
  get 'auth/failure', to: redirect('/')

  resources :users do
    member do
      get :edit_best, :channels, :videos, :playlists, :contents, :following, :follower
    end
  end

  # 本番環境でメールサーバーの契約予定がないため削除
  # resources :password_resets, only: %i[new create edit update]
  
  resources :relationships, only: %i[create destroy]
  resources :channels, only: %i[index], shallow: true do
    resources :channel_comments, only: %i[new create edit update destroy]
    member do
      get :users, :videos, :comments, :playlists
    end
  end
  resources :videos, only: %i[index show], shallow: true do
    resources :video_comments, only: %i[new create edit update destroy]
  end
  resources :contents, shallow: true do
    resources :content_comments, only: %i[new create edit update destroy]
  end
  resources :content_favorites, only: %i[create destroy]
  resources :best_channels_favorites, only: %i[create destroy]
  resources :best_videos_favorites, only: %i[create destroy]
  resource :best_videos, only: %i[edit update]
  resource :best_channels, only: %i[edit update]
  resource :subscription_channels, only: %i[edit update]
  resource :popular_videos, only: %i[edit update]
  resource :recent_content, only: %i[show]
  resource :user_playlists, only: %i[edit update]
end
