require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
  get "/" do
    erb :index
  end

  post "/selectgame" do
    (params[:name] == "") ? @name = "Player" : @name = params[:name]
    erb :selectgame
  end

  get "/online/pvp" do
    
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
