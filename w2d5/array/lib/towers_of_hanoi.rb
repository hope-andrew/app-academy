class TowersOfHanoiGame
  attr_accessor :stacks
  def initialize(stacks = [[3,2,1], [], []])
    @stacks = stacks
  end

  def move(grab, place)
    raise InvalidMoveError if stacks[grab].empty?
    if !stacks[place].empty? && stacks[grab].last > stacks[place].last
      raise InvalidMoveError
    end

    stacks[place] << stacks[grab].pop
  end

  def won?
    stacks[0].empty? && stacks[2].empty? || stacks[0].empty? && stacks[1].empty?
  end

  def render
    p stacks
  end
end


class InvalidMoveError < StandardError

end
