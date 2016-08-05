# frozen_string_literal: true
require 'node'

class AvlNode < Node
  attr_reader :weight

  def initialize key
    super
    @weight = 0
  end

  def add node
    super
    node < self ? @weight -= 1 : @weight += 1

    # puts weight
    if weight >= 2
      # rotate_cw
    end
    # super will just add node.
    # check the current weights here.
    # the hard thing is understanding that the root
    # node may have to change to ensure balance.
  end

  def insert node, parent = nil
    node < self ? insert_left(node, self) : insert_right(node, self)
  end

  def insert_left node, parent
    @left.nil? ? @left = node : @left.insert(node, self)
  end

  def insert_right node, parent
    @right.nil? ? @right = node : @right.insert(node, self)
  end

  def rotate_cw
    pivot = self.left
    swinger = pivot.right
    self.left = swinger
    pivot.right = self
  end

  def rotate_ccw
    pivot = self.right
    swinger = pivot.left
    self.right = swinger
    pivot.left = self
  end

  def size
    size = 0
    post_order_traverse { size += 1 }
    size
  end

  def post_order_traverse &block
    left&.post_order_traverse(&block)
    right&.post_order_traverse(&block)
    yield
  end
end
