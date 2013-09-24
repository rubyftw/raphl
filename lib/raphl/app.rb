require 'sinatra'

module Raphl
  class App < Sinatra::Application
    configure do
      enable :sessions

      # Redis Configuration
      uri = URI.parse(ENV["REDIS_URL"] || ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379")
      Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
      $redis = Redis::Namespace.new(:raphl, redis: Redis.current)
    end

    get "/alert" do
      redirect to("/")
    end

    # Entry Form
    get "/" do
      haml :index
    end

    # Form Submission
    post "/enter" do
      begin
        email = session[:email] = params.fetch("entry").fetch("email")
        raise "Must be present to win" unless params.fetch("entry").fetch("present") == "1"
        $redis.sadd("entries", email)
        redirect to("/thanks")
      rescue
        session[:message] = "Make sure you enter your email address and check the box."
        redirect to("/")
      end
    end

    get "/thanks" do
      haml :thanks
    end

    get "/entries" do
      @entries = $redis.smembers("entries")
      haml :entries
    end

    # Pick a winner
    get "/winner" do
      if $redis.smembers("entries").any?
        @winner = $redis.srandmember("entries")
        haml :winner
      else
        haml :no_entries
      end
    end
  end
end
