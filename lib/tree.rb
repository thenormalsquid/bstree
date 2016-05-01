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
    get_values node.left, collector if node.left
    collector << node.value
    get_values node.right, collector if node.right
  end

  def find key
    @root.find key
  end
end
