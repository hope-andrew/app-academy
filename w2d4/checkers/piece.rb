require_relative 'board'
require 'colorize'

class Piece

  attr_writer :king
  attr_reader :board, :color
  attr_accessor :position

  def initialize(board, position, color, king)
    @board = board
    @color = color
    @position = position
    @king = false
    @symbol = symbol(color)
  end

  def king?
    @king
  end

  def moves

  end

  def valid_move?(pos, piece, board)
    raise "not valid position" unless valid_pos?(pos)



  end

  def symbol(color)
    (color == :red ? "R ".colorize(:red) : "B ".colorize(:black) ) if king?
    (color == :red ? "r ".colorize(:red) : "b ".colorize(:black) )
  end

end
