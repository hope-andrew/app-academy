class Array

  def my_uniq
    self & self
  end

  def two_sum
    pairs = []
    self.each_index do |idx1|
      (idx1+1..self.length-1).each do |idx2|
        pairs << [idx1, idx2] if self[idx1] + self[idx2] == 0
      end
    end
    pairs
  end

  def my_transpose
    n = self.length
    transposed = Array.new(n) { Array.new(n) }
    n.times do |x|
      n.times do |y|
        transposed[y][x] = self[x][y]
      end
    end
    transposed
  end

  def stock_picker
    best_days = [0,1]

    self.each_index do |idx1|
      (idx1+1..self.length-1).each do |idx2|
        if self[idx2] - self[idx1] > self[best_days[1]] - self[best_days[0]]
          best_days = [idx1, idx2]
        end
      end
    end
    best_days
  end
end
