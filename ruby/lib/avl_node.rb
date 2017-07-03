# frozen_string_literal: true

require 'node'

class AvlNode < Node
  attr_accessor :weight
  attr_accessor :balance_factor

  def initialize key
    super
    @weight = 0
  end

  def rotate_cw
    parent = self.parent

    pivot = left
    swinger = pivot.right
    self.left = swinger
    # swinger&.parent = self.left
    pivot.right = self
    pivot.parent = parent
    parent&.right = pivot
    self.parent = pivot
  end
  alias_method :simple_right, :rotate_cw

  def rotate_ccw
    parent = self.parent

    pivot = right
    swinger = pivot.left
    self.right = swinger
    # swinger&.parent = self.right
    pivot.left = self
    pivot.parent = parent
    parent&.left = pivot
    self.parent = pivot
  end
  alias_method :simple_left, :rotate_ccw

  def rotate_left_right
    self.left.simple_left
    simple_right
  end

  def rotate_right_left
    self.right.simple_right
    simple_left
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

  def rebalance node
    # puts "from rebalance: node.object_id: #{node.object_id}, node.key: #{node.key}"
    # retrace, to root if necessary
  end

  # FIXME: Can't do it this way, need to handle the insert in the AvlTree
  # by calling the node insert first, then calling rebalance explicitly
  # after the insert. Otherwise way too much work gets done as all these
  # recursions fire the rebalance call.
  # TODO: walk the execution with pry to see how the recursion
  # works between the subclass and superclass.
  def insert node
    super
    # puts "from insert: self.object_id: #{self.object_id}, self.key: #{self.key}"
    # puts "from insert: node.object_id: #{node.object_id}, node.key: #{node.key}"
    rebalance node
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
