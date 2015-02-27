require_relative 'piece.rb'
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
        self[[row_idx, col]] = Piece.new(self, color, false)
      else
        next
      end
    end
  end

  def set_odd_row(row_idx, color)
    @grid[row_idx].each_index do |col|
      if col % 2 == 1
        self[[row_idx, col]] = Piece.new(self, color, false)
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

  def move(starting, ending, player_turn)

    raise "Invalid position " unless valid_pos?(starting) && valid_pos?(ending)


    piece = self[starting]
    raise "Must select a piece" if piece.nil?
    raise "Must select own piece" unless piece.color == player_turn

    if piece.perform_slide(starting, ending)
      self[ending] = piece
      self[starting] = nil
      return
    end

    if piece.perform_jump(starting, ending)
      self[ending] = piece
      self[starting] = nil
      self[intermediate_position(starting, ending)] = nil
      return
    end

    raise "Invalid move" if true

  end

  def intermediate_position(starting, ending)
    intermediate_x = (starting[0] + ending[0])/2
    intermediate_y = (starting[1] + ending[1])/2
    [intermediate_x, intermediate_y]
  end

  def pieces(color)
    count = 0
    @grid.each_index do |row|
      @grid[row].each_index do |col|
          next if self[[row,col]].nil?
          count +=1 if self[[row,col]].color == color
      end
    end
    count
  end



end

# b = Board.new
# b.render
# b.move([5,1], [4,2])
# b.render
# b.move([4,2], [3,3])
# b.render
# puts b[[2,4]].perform_jump([2,4], [4,2])
# b.move([2,4], [4,2])
# b.render
