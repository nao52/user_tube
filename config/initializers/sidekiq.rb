Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://172.17.0.1:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://172.17.0.1:6379' }
end