class PolyTreeNode
  attr_reader :children, :value, :parent

  def initialize value
    @value = value
    @parent = nil
    @children = []
  end

  def parent= the_parent
    unless @parent.nil?
      @parent = the_parent
      # @parent.children << self
    end
  end


end
