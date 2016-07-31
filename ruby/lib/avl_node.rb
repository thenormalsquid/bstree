# frozen_string_literal: true
require 'node'

class AvlNode < Node
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
