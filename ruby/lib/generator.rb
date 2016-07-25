require_relative './tree'
require_relative './node'

class Generator
  def build nodes
    tree = Tree.new(Node.new(nodes.shift))
    nodes.each { |n| tree.add(Node.new(n)) }
    tree
  end

  def self.tree1
    Generator.new.build [11]
  end

  def self.tree2
    Generator.new.build [11, 7]
  end
end
