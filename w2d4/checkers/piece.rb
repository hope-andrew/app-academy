require 'colorize'
require 'byebug'

class Piece

  attr_reader :board
  attr_accessor :king, :color

  def initialize(board, color, king)
    @board = board
    @color = color
    @king = false
    @symbol = symbol(color)
  end

  def king?
    @king
  end


  def perform_slide(starting, ending)

    # raise "must move your own piece" if position != starting

    moves = []
    move_diffs.each do |diff|
      row_coord = starting[0] + diff[0]
      col_coord = starting[1] + diff[1]
      new_pos = [row_coord, col_coord]
      if board.valid_pos?(new_pos) && board[ending].nil?
        moves << new_pos
      end
    end

    return true if moves.include?(ending)
    false

  end

  def perform_jump(starting, ending)
    moves = []

    jump_diffs.each do |diff|
      row_coord = starting[0] + diff[0]
      col_coord = starting[1] + diff[1]
      new_pos = [row_coord, col_coord]

      if board.valid_pos?(new_pos) && board[ending].nil?
        moves << new_pos
      end

    end

    if moves.include?(ending) && check_intermediate_piece(starting, ending)
      return true
    end
      false
  end

  def check_intermediate_piece(starting, ending)
      intermediate_x = (starting[0] + ending[0])/2
      intermediate_y = (starting[1] + ending[1])/2
      intermediate_pos = [intermediate_x, intermediate_y]

      return false if board[intermediate_pos] == nil
      return true if board[intermediate_pos].color != @color
      false
  end

  def jump_diffs

    diffs_red = [[2, -2], [2, 2]]
    diffs_black = [[-2, -2], [-2, 2]]
    diffs_king = [[2, -2], [2, 2], [-2, -2], [-2, 2]]

    return diffs_king if king?
    return diffs_red if color == :red
    return diffs_black if color == :black


  end

  def move_diffs
    diffs_red = [[1, -1], [1, 1]]
    diffs_black = [[-1, -1], [-1, 1]]
    diffs_king = [[1, -1], [1, 1], [-1, -1], [-1, 1]]

    return diffs_king if king?
    return diffs_red if color == :red
    return diffs_black if color == :black
  end

  def symbol(color)
    (color == :red ? "R ".colorize(:red) : "B ".colorize(:black) ) if king?
    (color == :red ? "r ".colorize(:red) : "b ".colorize(:black) )
  end

end
