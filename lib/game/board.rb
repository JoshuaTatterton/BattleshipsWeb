class Board

  attr_reader :view_board
  
  def initialize
    @view_board = Array.new(10) { Array.new(10) { :w } }
  end

  def place_ship(ship,coord,direction)
    direction == :horizontal ? ship_placerH(ship,coord) : ship_placerV(ship,coord)
  end

  private

  attr_writer :view_board

  def symN(symbol)
    return symbol.to_i - 1
  end
  def symL(symbol)
    return (symbol.to_s).ord - 65
  end
  
  def ship_placerH(ship,coord)
    bounds_checkerH(ship,coord)
    location_checker(ship_spanH(ship,coord))
    i = 0
    ship.size.times { view_board[symN(coord[1])][symL(coord[0]) + i] = ship.board_rep; i+=1 }
  end
  def ship_spanH(ship,coord)
    i = 0
    span = []
    ship.size.times { span << (view_board[symN(coord[1])][symL(coord[0]) + i] == :w); i+=1 }
    return span
  end
  def bounds_checkerH(ship, coord)
    minx = symL(coord[0])
    y = symN(coord[1])
    maxx = symL(coord[0]) + ship.size
    fail "Out of bounds" if minx < 0 || y > 9 || y < 0 || maxx > 9
  end
  def ship_placerV(ship,coord)
    bounds_checkerV(ship,coord)
    location_checker(ship_spanV(ship,coord))
    i = 0
    ship.size.times { view_board[symN(coord[1]) + i][symL(coord[0])] = ship.board_rep; i+=1 }
  end
  def ship_spanV(ship,coord)
    i = 0
    span = []
    ship.size.times { span << (view_board[symN(coord[1]) + i][symL(coord[0])] == :w); i+=1 }
    return span
  end
  def bounds_checkerV(ship,coord)
    miny = symN(coord[1])
    x = symL(coord[0])
    maxy = symN(coord[1]) + ship.size
    fail "Out of bounds" if miny < 0 || x > 9 || x < 0 || maxy > 9
  end
  def location_checker(span)
    fail "Ship already at location" if span.include?(false)
  end
end