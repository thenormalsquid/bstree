require_relative './node'

class Tree
  attr_reader :root, :size

  def initialize node = nil
    @root = node ? node : Node.new
    @size = 1
  end

  def add node
    @root.add node
    @size += 1
  end

  def collect
    collector = []
    get_values @root, collector
    collector
  end

  def get_values node, collector
    if node.left
      get_values node.left, collector
    end

    collector << node.value

    if node.right
      get_values node.right, collector
    end
  end
end
