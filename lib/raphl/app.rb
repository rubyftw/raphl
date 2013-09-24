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
      @entries = $redis.smembers("entries")
      if @entries.any?
        @winner = true_random_select(@entries)
        haml :winner
      else
        haml :no_entries
      end
    end

    def true_random_select(collection)
      max = collection.count
      entry_index = HTTParty.get("http://www.random.org/integers/?num=1&min=0&max=#{ max-1 }&col=1&base=10&format=plain").to_s.to_i
      collection[entry_index]
    end
  end
end
