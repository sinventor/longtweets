Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/15' }
  config.poll_interval = 15 * 2
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/15' }
end