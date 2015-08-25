require_relative "board"

class Play

  attr_reader :player1_board, :player2_board

  def initialize
    @player1_board = Board.new
    @player2_board = Board.new
  end

  def player1_place(ship,coord,direction)
    player1_board.place_ship(ship,coord,direction)
  end

  def player2_place(ship,coord,direction)
    player2_board.place_ship(ship,coord,direction)
  end

  def player1_fire(coord)
    report = player2_board.fire(coord) 
    report == :sunk ? player1_check : :hit
  end

  def player2_fire(coord)
    report = player1_board.fire(coord)
    report == :sunk ? player2_check : :hit
  end

  private

  def player1_check
    (player2_board.winner?) ? :player1 : :sunk
  end
  def player2_check
    player1_board.winner? ? :player2 : :sunk
  end
end