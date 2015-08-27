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

  def player1_view_own
    pretty_own(player1_board.view_board)
  end
  def player2_view_own
    pretty_own(player2_board.view_board)
  end

  def player1_view_opponent
    pretty_opponent(player2_board.view_board)
  end
  def player2_view_opponent
    pretty_opponent(player1_board.view_board)
  end

  private

  def pretty_own(board)
    lines = board.map { |x| x.join(" ") }
    pretty = "     A B C D E F G H I J     
     – – – – – – – – – –     
1  | #{lines[0]} |  1
2  | #{lines[1]} |  2
3  | #{lines[2]} |  3
4  | #{lines[3]} |  4
5  | #{lines[4]} |  5
6  | #{lines[5]} |  6
7  | #{lines[6]} |  7
8  | #{lines[7]} |  8
9  | #{lines[8]} |  9
10 | #{lines[9]} | 10
     – – – – – – – – – –     
     A B C D E F G H I J     "
  end

  def pretty_opponent(board)
    board = transform(board)
    lines = board.map { |x| x.join(" ") }
    pretty = "     A B C D E F G H I J     
     – – – – – – – – – –     
1  | #{lines[0]} |  1
2  | #{lines[1]} |  2
3  | #{lines[2]} |  3
4  | #{lines[3]} |  4
5  | #{lines[4]} |  5
6  | #{lines[5]} |  6
7  | #{lines[6]} |  7
8  | #{lines[7]} |  8
9  | #{lines[8]} |  9
10 | #{lines[9]} | 10
     – – – – – – – – – –     
     A B C D E F G H I J     "
  end

  def transform(board)
    board.map { |x| x.map { |y| (y==:h || y==:m) ? y : :w } }
  end

  def player1_check
    (player2_board.winner?) ? :winner : :sunk
  end
  def player2_check
    player1_board.winner? ? :winner : :sunk
  end
end