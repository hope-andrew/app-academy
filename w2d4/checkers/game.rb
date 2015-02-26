require_relative 'piece'
require_relative 'board'

class Game

  def initialize
    @board = Board.new

  end
  def move_sequence
    puts "Starting position (e.g x,y)"
    starting = gets.chomp.split(",")
    puts "Ending position (e.g x,y)"
    ending = gets.chomp.split(",")

    [starting, ending]
  end

end
