class Ship
  DESTROYER_SIZE = 1
  CRUISER_SIZE = 2
  SUBMARINE_SIZE = 3
  BATTLESHIP_SIZE = 4
  AIRCRAFT_CARRIER_SIZE = 5

  def self.destroyer
    new(DESTROYER_SIZE)
  end

  def self.cruiser
    new(CRUISER_SIZE)
  end
  
  def self.submarine
    new(SUBMARINE_SIZE)
  end

  def self.battleship
    new(BATTLESHIP_SIZE)
  end

  def self.aircraft_carrier
    new(AIRCRAFT_CARRIER_SIZE)
  end

  attr_reader :size
  
  def initialize(size)
    @size = size
  end

  
end