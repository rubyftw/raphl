require 'sinatra'

module Raphl
  class App < Sinatra::Application
    # Entry Form
    get "/" do
      "Raffle Entry"
    end

    # Form Submission
    post "/enter" do
    end

    # Pick a winner
    get "/winner" do
    end
  end
end
