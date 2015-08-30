class Game

  include DataMapper::Resource

  property :id, Serial
  property :play, String, :length => 10000
  property :player_turn, Integer
  property :last_move, String
  property :last_status, String
  property :player1, Integer
  property :player2, Integer

  def self.last_game
    all_games = self.all
    return all_games.last
  end
end