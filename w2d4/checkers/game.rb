require_relative 'board'
require 'colorize'
require 'byebug'

class Game
  COLORS = [:red, :black]

  attr_accessor :player_turn
  attr_reader :board
  def initialize
    @board = Board.new
    @player_turn = :red

  end

  def play
    while won? == false
      p player_turn
      turn
    end

    puts "#{won?.upcase} wins!"
  end

  def turn
    board.render
    puts "Player Turn: " + player_turn.to_s.colorize(player_turn)
    puts "Starting position (e.g x,y)"
    starting = gets.chomp.split(",").map(&:to_i)
    puts "Ending position (e.g x,y)"
    ending = gets.chomp.split(",").map(&:to_i)
    board.move(starting, ending, player_turn)
    debugger
    self.player_turn = (player_turn == :red ? :black : :red)
  end

  def won?
    if board.pieces(:red) == 0
      :black
    elsif board.pieces(:black) == 0
      :red
    else
      false
    end
  end

  def move_sequence
    puts "Starting position (e.g x,y)"
    starting = gets.chomp.split(",")
    puts "Ending position (e.g x,y)"
    ending = gets.chomp.split(",")

    [starting, ending]
  end

end

game = Game.new
game.play
