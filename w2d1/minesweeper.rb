class MineSweeperGame

  def initialize(num_of_bombs)
    @board = Board.new.initialize_tiles
    @num_of_bombs = num_of_bombs
    @bomb_index = []
    @explored_index = []
    @flagged_index = []
  end

  def play

      until @won == true || @lost == true #check win condition

      end
  end

  def check_if_won
    @won = true
    @board.each do |row|
      if row.include?("*")
        @won = false
      end
    end
    unless @flagged_index.length == @bomb_index.length
      @won == false
    end
    @won
  end

  def check_if_lost
    # @lost = true


  end

  def turn
    @board.display
    puts "Please select a space: 'r,c'"
    space = gets.chomp.split(",").map(&:to_i)
    puts "Reveal or Place Flag? 'r/f' "
    choice = gets.chomp
      if choice == "r"

      else #choice == "f"
        @board[space[0]][space[1]].place_flag
      end
  end

end


class Board
  attr_accessor :bomb_index

  def initialize
    @grid = Array.new(9){Array.new(9){}}
  end

  def self.place_bomb
    n = 0
    while n < num_of_bomb
      first_num = rand(8)
      second_num = rand(8)
      unless @bomb_index.include?([first_num, second_num])
        @bomb_index << [first_num, second_num]
        n += 1
      end
    end
  end

  def initialize_tiles
    @grid.each_with_index do |row, row_ind|
      row.each_with_index do |item, col_ind|
        make_tile(row_ind, col_ind)
      end
    end
  end

  def make_tile(r,c)
     @grid[r][c] = Tile.new(r,c, self)
  end

  def display
    @grid.each do |row|
      p row
    end
  end

  def tile_at(pos)
    row, col = pos
      @grid[row][col]
  end
end

class Tile
  attr_accessor :location, :value, :bombed, :flagged, :bomb_count, :reveal

  def initialize(row, col, board)
    @board = board
    @location = [row,col]
    @bombed = false
    @flagged = false
    @revealed = false
    @value = "*"
    @bomb_count = 0
  end

  def define_bomb_value
    @board.bomb_index.each do |arr|
      @board[arr[0]][arr[1]].bombed = true
    end
  end

  def inspect
    @value
  end

  def reveal
    r = @location[0]
    c = @location[1]

    if @board.tile_at(@location).bomb_count > 0
      @board.tile_at(@location).value = "#{@bomb_count}"
    else
      @board.tile_at(@location).neighbors
      @adj.each do |neigh|
        neigh = @board.tile_at(neigh)
        if neigh.value == "*" && neigh.bomb_count < 1 && neigh
          neigh.value = "_"
          neigh.reveal
        end
      end
    end
  end

  def neighbors
    @adj = []
    r = @location[0]
    c = @location[1]

    @adj << [r - 1, c + 1] unless r - 1 < 0 || c + 1 > (8)
    @adj << [r - 1, c    ] unless r - 1 < 0
    @adj << [r - 1, c - 1] unless r - 1 < 0 || c - 1 < 0
    @adj << [r    , c - 1] unless              c - 1 < 0
    @adj << [r    , c + 1] unless              c + 1 > 8
    @adj << [r + 1, c - 1] unless r + 1 > (8) || c-1 < 0
    @adj << [r + 1, c    ] unless r + 1 > (8)
    @adj << [r + 1, c + 1] unless r + 1 > (8) || c + 1 > (8)
  end

  def neighbor_bomb_count
    @adj.each do |pos|
      if @board[pos[0], pos[1]].bombed == true
        @bomb_count += 1
      end
    end
  end

  def place_flag
    @flagged = true
    @value = "f"
  end
end

b = Board.new
b.initialize_tiles
b.tile_at([0,0]).reveal
b.display
