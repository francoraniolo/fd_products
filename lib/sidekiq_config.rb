require 'sidekiq'
require_relative 'jobs/product_creation_job'

Sidekiq.configure_server do |config|
  #config.redis = { url: 'redis://localhost:6379/0' }
  config.redis = { url: 'redis://redis:6379/0', network_timeout: 10 }
end

Sidekiq.configure_client do |config|
  #config.redis = { url: 'redis://localhost:6379/0' }
  config.redis = { url: 'redis://redis:6379/0', network_timeout: 10 }
end
