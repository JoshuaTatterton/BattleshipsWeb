class Game

  include DataMapper::Resource

  property :id, Serial
  property :play, Class
  property :player_turn, Integer
  property :player1_id, Integer
  property :player2_id, Integer, required: false

  def self.last_game
    all_games = self.all
    return all_games.last
  end
end