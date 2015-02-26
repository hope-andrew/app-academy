require_relative 'piece'
require 'colorize'

class Board

  def initialize(fill_board = true )
    @grid = Array.new(8){Array.new(8){nil}}

    set_pieces if fill_board


  end

  def [](pos)
    pos_x = pos[0]
    pos_y = pos[1]

    @grid[pos_x][pos_y]
  end

  def []=(pos, piece)
    pos_x = pos[0]
    pos_y = pos[1]

    @grid[pos_x][pos_y] = piece
  end

  def set_pieces

    set_even_row(0, :red)
    set_odd_row(1,:red)
    set_even_row(2, :red)

    set_odd_row(5, :black)
    set_even_row(6, :black)
    set_odd_row(7, :black)
  end

  def set_even_row(row_idx, color)
    @grid[row_idx].each_index do |col|
      if col % 2 == 0
        self[[row_idx, col]] = Piece.new(self, [row_idx, col], color, false)
      else
        next
      end
    end
  end

  def set_odd_row(row_idx, color)
    @grid[row_idx].each_index do |col|
      if col % 2 == 1
        self[[row_idx, col]] = Piece.new(self, [row_idx, col], color, false)
      else
        next
      end
    end
  end

  def valid_pos?(pos)
    return true if pos.all?{|coord| (0..7).include?(coord)}
    false
  end

  def empty?(pos)
    self[pos].nil?
  end

  def render

    render_string = ""
    @grid.each_index do |row|
      render_string += render_row(row, :red)
      render_string += "\n"
    end
    puts render_string
  end

  def render_row(row_num, color)
    render_string = ""
    @grid[row_num].each_index do |col|
      if self[[row_num,col]].nil?
        render_string << "_ "
      else
        piece = self[[row_num, col]]
        render_string << piece.symbol(piece.color)
      end
    end

    render_string
  end

  # def move(starting, ending, current_player_color)
  #
  #   piece = self[starting]
  #
  #   raise "starting postion empty" if self[starting].nil?
  #
  #   if piece.color != current_player
  #     raise "you must move your own piece"
  #   elsif
  #
  #
  #
  # end

  def valid_move?(pos, piece)
    raise "not valid position" unless board.valid_pos?(pos)







  end



end
