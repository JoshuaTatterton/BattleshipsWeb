require_relative "ship_section"

class Ship
  DESTROYER_SIZE = 1
  CRUISER_SIZE = 2
  SUBMARINE_SIZE = 3
  BATTLESHIP_SIZE = 4
  AIRCRAFT_CARRIER_SIZE = 5

  def self.destroyer
    new(DESTROYER_SIZE,:d)
  end
  def self.cruiser
    new(CRUISER_SIZE,:c)
  end
  def self.submarine
    new(SUBMARINE_SIZE,:s)
  end
  def self.battleship
    new(BATTLESHIP_SIZE,:b)
  end
  def self.aircraft_carrier
    new(AIRCRAFT_CARRIER_SIZE,:a)
  end

  attr_reader :size, :ship, :board_rep
  
  def initialize(size,sym)
    @size = size
    @ship = Array.new(size) { Ship_Section.new }
    @board_rep = sym
  end

  
end