require_relative 'board'
require 'colorize'

class Piece

  attr_writer :king
  attr_reader :board, :color

  def initialize(board, color, king)
    @board = board
    @color = color
    @king = false
    @symbol = symbol(color)
  end

  def king?
    @king
  end

  def symbol(color)
    (color == :red ? "R ".colorize(:red) : "B ".colorize(:black) ) if king?
    (color == :red ? "r ".colorize(:red) : "b ".colorize(:black) )
  end

end
