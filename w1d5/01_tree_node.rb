class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent = nil)
    unless self.parent == nil #|| parent.children.include?(self)
      @parent.chidlren.delete(self)
      @parent = parent
      parent.children << self

    end
  end
end
