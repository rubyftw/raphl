module Raphl
  class App < Sinatra::Application
    configure do
      enable :sessions

      # Redis Configuration
      uri = URI.parse(ENV["REDIS_URL"] || ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379")
      Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
      $redis = Redis::Namespace.new(:raphl, redis: Redis.current)
    end
  end
end
