Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Settings.google_client_id, Settings.google_client_secret, scope: 'email, profile, https://www.googleapis.com/auth/youtube.force-ssl'
end