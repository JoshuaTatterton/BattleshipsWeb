class Board

  attr_reader :view_board
  
  def initialize
    @view_board = Array.new(10) { Array.new(10) { :w } }
  end
end