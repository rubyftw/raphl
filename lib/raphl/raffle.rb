module Raphl
  class App < Sinatra::Application
    register Sinatra::Namespace

    namespace "/:raffle" do

      before { @raffle = params[:raffle] }

      # Entry Form
      get("/?") { haml :index }
      get("/thanks/?") { haml :thanks }

      # Form Submission
      post "/enter/?" do
        begin
          params.fetch("entry").fetch("present")
          email = session[:email] = params.fetch("entry").fetch("email")

          $redis.sadd("#@raffle:entries", email)

          redirect to("/#@raffle/thanks")
        rescue KeyError
          session[:message] = "Make sure you enter your email address and check the box."
          redirect to("/#@raffle")
        end
      end

      # View Entries
      get "/entries/?" do
        @entries = $redis.smembers("#@raffle:entries")

        haml :entries
      end

      # Pick a winner
      get "/winner/?" do
        @entries = $redis.smembers("#@raffle:entries")

        @winner = TrueRandom.select(@entries)

        haml :winner
      end

    end

  end
end

