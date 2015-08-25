class Ship_Section

  attr_reader :location

  def initialize
    @hit = false
  end

  def hit
    @hit = true
  end

  def hit?
    @hit
  end

  def set(coord)
    @location = coord
  end
  
end