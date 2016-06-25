module BinarySearchTree
  attr_accessor :left, :right

  def add(node)
    if node < self
      self.left.nil? ? self.left = node : self.add(node)
    else
      self.right.nil? ? self.right = node : self.add(right, node)
    end
  end
end
