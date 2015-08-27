class Player

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :game_id, Integer

end