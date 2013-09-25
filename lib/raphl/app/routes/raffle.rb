module Raphl
  class App < Sinatra::Application
    register Sinatra::Namespace

    namespace "/:raffle" do

      before { @raffle = params[:raffle] }

      # Entry Form
      get("/?")        { haml :enter }
      get("/thanks/?") { haml :thanks }

      # Form Submission
      post "/enter/?" do
        @entry = Entry.new({
          email:    params["entry"]["email"],
          raffle:   @raffle,
          terms:    !!params["entry"]["terms"]
        })

        if @entry.save
          redirect to("/#@raffle/thanks")
        else
          session[:message] = "Make sure you enter your email address and accept the terms."
          redirect to("/#@raffle")
        end
      end

      # View Entries
      get "/entries/?" do
        @entries = Entry.all(@raffle)

        haml :entries
      end

      # Pick a winner
      get "/winner/?" do
        @entries = Entry.all(@raffle)
        @winner  = Entry.select(@raffle)

        haml :winner
      end

    end

  end
end

