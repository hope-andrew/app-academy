class PolyTreeNode
  attr_reader :children, :value, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(the_parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = the_parent
    unless @parent.nil? || @parent.children.include?(self)
      @parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "the node is not a child" if !@children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    result = nil
    if @value == target_value
      return self
    else
      @children.each do |child|
        result = child.dfs(target_value)
        return result if !result.nil?
      end
    end
    return result
  end

  def bfs(target_value)
    queue = [self]
    while true
      if queue.empty?
        return nil
      else
        current_node = queue.shift
        return current_node if current_node.value == target_value
        queue.concat(current_node.children)
      end
    end
  end

  def trace_back_path
    return [@value] if @parent.nil?
    self.parent.trace_back_path << @value
  end
end

class KnightPathFinder
  DELTA = [
    [-2, 1], [-2, -1],
    [2, 1], [2, -1],
    [1, 2], [-1, 2],
    [1, -2], [-1, -2]
  ]

  def initialize(start_position)
    @start_position = start_position
    @visited_positions = [start_position]
    @root = build_move_tree
  end

  def self.valid_moves(pos)
    valid_moves = []
    DELTA.each do |change|
      current_x = change[0] + pos[0]
      current_y = change[1] + pos[1]
      if current_x.between?(0,7) && current_y.between?(0,7)
        valid_moves << [current_x, current_y]
      end
    end
    valid_moves
  end

  def new_move_position(pos)
    new_moves = []
    possible_moves = KnightPathFinder.valid_moves(pos)
    possible_moves.each do |move|
      unless @visited_positions.include?(move)
        new_moves << move
        @visited_positions << move
      end
    end
    new_moves
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_position)
    queue = [root]
    until queue.empty?
      curr_node = queue.shift
      new_moves = new_move_position(curr_node.value)
      new_moves.each do |move|
        new_node = PolyTreeNode.new(move)
        new_node.parent = curr_node
        queue << new_node
      end
    end
    root
  end

  def find_path(end_pos)
    final_node = @root.bfs(end_pos)
    return nil if final_node.nil?
    final_node.trace_back_path
  end
end
