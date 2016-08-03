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
    # super will just add node.
    # check the current weights here.
    # the hard thing is understanding that the root
    # node may have to change to ensure balance.
  end

  def rotate_ccw
    pivot = self.left
    swinger = pivot.right
    self.left = swinger
    pivot.right = self
  end

  def rotate_cw
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
