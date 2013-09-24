require 'sinatra'
require 'sinatra/namespace'

require 'raphl/configuration'
require 'raphl/raffle'

module Raphl
  class App < Sinatra::Application
    get "/" do
      @domain = request.url.sub(/\/$/,'')
      haml :index
    end

    post "/new" do
      @raffle = params.fetch("raffle")
      redirect to("/#@raffle")
    end
  end
end
