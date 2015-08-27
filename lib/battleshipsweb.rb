require "sinatra/base"
require "sinatra/session"
require_relative "../data_mapper_setup"
require_relative "game"

class BattleshipsWeb < Sinatra::Base

  enable :sessions

  get "/" do
    erb :index
  end

  post "/selectgame" do
    @name = (params[:name] == "") ? "Player" : params[:name]
    player = Player.create(name: @name)
    session[:player_id] = player.id
    erb :selectgame
  end

  get "/online/pvp" do
    @name = get_name(session[:player_id])
    startcreate_game(session[:player_id])
    erb :"online/pvp"
  end

  helpers do
    def startcreate_game(player_id)
      # lastgame = Game.last_game
      # if lastgame == nil || lastgame.player2_id != nil
      Game.create(play: Play.new, player_turn: player_id, player1_id: player_id)
    end
    def get_name(player_id)
      Player.get(player_id).name
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
