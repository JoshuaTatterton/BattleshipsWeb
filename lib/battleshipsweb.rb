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

  get "/online/pvp/p1/place" do
    @p1 = get_name(session[:player_id])
    erb :"online/pvp/p1/place"
  end

  helpers do
    def startcreate_game(player_id)
      lastgame = Game.last_game
      if lastgame == nil || lastgame.player2 != nil
        play = Marshal::dump(Play.new)
        game = Game.create(play: play, player_turn: player_id, player1: player_id)
      else
        lastgame.update(player2: player_id)
        game = lastgame
        @p2 = get_name(lastgame.player1)
      end
      set_game(player_id,game)
    end
    def get_name(player_id)
      Player.get(player_id).name
    end
    def set_game(player_id, game)
      player = Player.get(player_id)
      player.update(:game_id => game.id)
      player.save
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
