module BinarySearchTree
  attr_accessor :left, :right

  def add node
    if node < self
      left.nil? ? self.left = node : left.add(node)
    else
      right.nil? ? self.right = node : right.add(node)
    end
  end

  def collect collector
    left.collect collector unless left.nil?
    collector.push @key
    right.collect collector unless right.nil?
  end

  def find key
    return self if @key == key
    if key < @key
      # left.nil? ? nil : left.find(key)
      left&.find(key)
    else
      # right.nil? ? nil : right.find(key)
      right&.find(key)
    end
  end

  def maximum
    # right.nil? ? self : right.maximum
    right&.maximum or self
  end

  def minimum
    # left.nil? ? self : left.minimum
    left&.minimum or self
  end
end
