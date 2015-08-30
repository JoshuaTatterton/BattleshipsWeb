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
    game = Game.last(:player1 => session[:player_id])
    game.play
    play = YAML::load(game.play)
    @game = play
    erb :"online/pvp/p1/place"
  end

  get "/online/pvp/p2/place" do
    @p2 = get_name(session[:player_id])
    game = Game.last(:player2 => session[:player_id])
    game.play
    play = YAML::load(game.play)
    @game = play
    erb :"online/pvp/p2/place"
  end

  get "/online/pvp/p1/:type/:location/:direction" do
    game = Game.last(player1: session[:player_id])
    play = YAML::load(game.play)
    play.player1_place(Ship.send(params[:type]),params[:location].capitalize.to_sym,params[:direction].to_sym)
    play = YAML::dump(play)
    game.update(play: play)
  end

  get "/online/pvp/p2/:type/:location/:direction" do
    game = Game.last(player2: session[:player_id])
    play = YAML::load(game.play)
    play.player2_place(Ship.send(params[:type]),params[:location].capitalize.to_sym,params[:direction].to_sym)
    play = YAML::dump(play)
    game.update(play: play)
  end

  get "/online/pvp/p1/board" do
    game = Game.last(player1: session[:player_id])
    play = YAML::load(game.play)
    "#{play.player1_view_own}"
  end

  get "/online/pvp/p2/board" do
    game = Game.last(player2: session[:player_id])
    play = YAML::load(game.play)
    "#{play.player2_view_own}"
  end

  post "/online/pvp/p1/lobby" do
    game = Game.last(player1: session[:player_id])
    play = YAML::load(game.play)
    play.player1_place(Ship.destroyer,params[:location].capitalize.to_sym,params[:direction].to_sym)
    play = YAML::dump(play)
    game.update(play: play)
    redirect "online/pvp/p1/lobby"
  end

  post "/online/pvp/p2/lobby" do
    game = Game.last(player2: session[:player_id])
    play = YAML::load(game.play)
    play.player2_place(Ship.destroyer,params[:location].capitalize.to_sym,params[:direction].to_sym)
    play = YAML::dump(play)
    game.update(play: play, player_turn: game.player1)
    redirect "/online/pvp/p2/play"
  end

  get "/online/pvp/p1/lobby" do
    @id = session[:player_id]
    erb :"online/pvp/p1/lobby"
  end

  get "/online/pvp/p1/play" do
    game = Game.last(player1: session[:player_id])
    @p1 = get_name(game.player1)
    @p2 = get_name(game.player2)
    @id = session[:player_id]
    @game = YAML::load(game.play)
    erb :"online/pvp/p1/play"
  end

  get "/online/pvp/p2/play" do
    game = Game.last(player2: session[:player_id])
    @p1 = get_name(game.player1)
    @p2 = get_name(game.player2)
    @id = session[:player_id]
    @game = YAML::load(game.play)
    erb :"online/pvp/p2/play"
  end

  post "/online/pvp/p1/play" do
    game = Game.last(player1: session[:player_id])
    @game = YAML::load(game.play)
    @result = @game.player1_fire(params[:location].capitalize.to_sym)
    @location = params[:location].capitalize
    @p1 = get_name(game.player1)
    @p2 = get_name(game.player2)
    @id = session[:player_id]
    play = YAML::dump(@game)
    game.update(play: play, player_turn: game.player2, last_move: @location, last_status: @result.to_s)
    erb :"online/pvp/p1/play"
  end

  post "/online/pvp/p2/play" do
    game = Game.last(player2: session[:player_id])
    @game = YAML::load(game.play)
    @result = @game.player2_fire(params[:location].capitalize.to_sym)
    @location = params[:location].capitalize
    @p1 = get_name(game.player1)
    @p2 = get_name(game.player2)
    @id = session[:player_id]
    play = YAML::dump(@game)
    game.update(play: play, player_turn: game.player1, last_move: @location, last_status: @result.to_s)
    erb :"online/pvp/p2/play"
  end

  get "/online/pvp/p1/turn" do
    game = Game.last(player1: session[:player_id])
    "#{game.player_turn}"
  end

  get "/online/pvp/p2/turn" do
    game = Game.last(player2: session[:player_id])
    "#{game.player_turn}"
  end

  get "/online/pvp/last/move" do
    player = Player.get(session[:player_id])
    game = Game.get(player.game_id)
    "#{game.last_move}"
  end

  get "/online/pvp/last/status" do
    player = Player.get(session[:player_id])
    game = Game.get(player.game_id)
    "#{game.last_status}"
  end

  helpers do
    def startcreate_game(player_id)
      lastgame = Game.last_game
      if lastgame == nil || lastgame.player2 != nil
        play = YAML::dump(Play.new)
        game = Game.create(play: play, player1: player_id)
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
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
