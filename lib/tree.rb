require_relative './node'

class Tree
  attr_reader :root

  def initialize node = nil
    @root = node ? node : Node.new
  end

  def add node
    # This is the bogus. Let's make a simple binary tree
    # first, without worrying about balance.
    @root.left = node

    return
  
    # if node.value < @root.value

     
  end 
end
