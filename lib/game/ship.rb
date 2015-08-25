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

  def setV(coord)
    @coord = coord
    ship.each { |x| x.set(@coord); coord_increaseV }
  end

  def setH(coord)
    @coord = coord
    ship.each { |x| x.set(@coord); coord_increaseH }
  end

  def hit(coord)
    ship.each { |x| x.hit if (x.location == coord) }
  end

  def sunk?
    !hits.include?(false)
  end

  private

  def coord_increaseV
    num = @coord[1]
    @coord = (@coord[0] + ((num.to_i) + 1).to_s).to_sym
  end

  def coord_increaseH
    str = @coord[0]
    @coord = ((str.ord+1).chr + @coord[1]).to_sym
  end

  def hits
    return ship.map { |x| x.hit? }
  end
end