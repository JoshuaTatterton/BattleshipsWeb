class Game

  include DataMapper::Resource

  property :id, Serial
  property :play, Text
  property :player_turn, Integer
  property :player1, Integer
  property :player2, Integer

  def self.last_game
    all_games = self.all
    return all_games.last
  end
end