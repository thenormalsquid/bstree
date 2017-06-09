# frozen_string_literal: true

require 'node'

class AvlNode < Node
  attr_reader :weight

  def initialize key
    super
    # @weight = 0
  end

  # TODO: will need to adjust weight at each affected node.
  def rotate_cw
    pivot = left
    swinger = pivot.right
    self.left = swinger
    pivot.right = self
  end
  alias_method :simple_right, :rotate_cw

  # TODO: will need to adjust weight at each affected node.
  def rotate_ccw
    pivot = right
    swinger = pivot.left
    self.right = swinger
    pivot.left = self
  end
  alias_method :simple_left, :rotate_ccw

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

  def rebalance node
    # retrace, to root if necessary
  end

  # TODO: walk the execution with pry to see how the recursion
  # works between the subclass and superclass.
  def insert node
    super
    puts "self.object_id: #{self.object_id}, self.key: #{self.key}"
    puts "node.object_id: #{node.object_id}, node.key: #{node.key}"
    # rebalance node
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
