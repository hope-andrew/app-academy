class Board
  def initialize
    @board = Array.new(3) {Array.new(2, 0)}
    @occupied_pos = []
  end

  def won?

    win1 = [[0, 0], [0, 1], [0, 2]]
    win2 = [[1, 0], [1, 1], [1, 2]]
    win3 = [[2, 0], [2, 1], [2, 2]]
    win4 = [[0, 0], [1, 0], [2, 0]]
    win5 = [[0, 1], [1, 1], [2, 1]]
    win6 = [[0, 2], [1, 2], [2, 2]]
    win7 = [[0, 0], [1, 1], [2, 2]]
    win8 = [[0, 2], [1, 1], [2, 0]]

    winning_opts = [win1, win2,win3, win4, win5, win6, win7, win8]
  end

  def winner
    return true if winning_opts.include?(@occupied_pos)
  end

  def empty?(pos)
    row = pos[0]
    col = pos[1]
    true if @board[row][col] == 0
  end

  def place_mark(pos, mark)
    if empty?(pos)
      @board[pos[0]][pos[1]] = mark
      @occupied_pos << pos
    end
  end
end

class Game
  def play

  end
end

class HumanPlayer

end

class ComputerPlayer

end
