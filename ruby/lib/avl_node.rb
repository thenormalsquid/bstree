# frozen_string_literal: true

require 'node'

class AvlNode < Node
  attr_accessor :balance_factor

  def initialize key
    super
    @balance_factor = 0
  end

  def rotate_right
    parent = self.parent

    pivot = left
    swinger = pivot.right
    self.left = swinger
    swinger&.parent = self.left # <- this thing might crash
    pivot.right = self
    pivot.parent = parent
    parent&.right = pivot
    self.parent = pivot
  end

  def rotate_left
    parent = self.parent

    pivot = right
    swinger = pivot.left
    self.right = swinger
    swinger&.parent = self.right # <- this thing might crash
    pivot.left = self
    pivot.parent = parent
    parent&.left = pivot
    self.parent = pivot
  end

  def rotate_left_right
    self.left.rotate_left
    rotate_right
  end

  def rotate_right_left
    self.right.rotate_right
    rotate_left
  end

  def right_height
    right.nil? ? 0 : right.height + 1
  end

  def left_height
    left.nil? ? 0 : left.height + 1
  end

  def weight
    right_height - left_height
  end

  def balanced?
    [-1, 0, 1].include? weight
  end

  def insert node
    super
  end

  # TODO: see if this can punt to the parent Node class.
  # Move the relevant tests to shared examples.
  def size
    size = 0
    post_order_traverse { size += 1 }
    size
  end

  # TODO: see if this can punt to the parent Node class.
  def post_order_traverse &block
    left&.post_order_traverse(&block)
    right&.post_order_traverse(&block)
    yield
  end
end
