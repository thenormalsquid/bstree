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

  # TODO: will need to adjust weight at each affected node.
  def rotate_ccw
    pivot = right
    swinger = pivot.left
    self.right = swinger
    pivot.left = self
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
    # [-1, 0, 1].include?(right_height - left_height)
  end

  def insert node
    super
    # node < self ? @weight -= 1 : @weight += 1

    # puts "done inserting..."

    # puts weight
    # if weight >= 2
    #   rotate_cw
    # end
    # super will just insert node.
    # check the current weights here.
    # the hard thing is understanding that the root
    # node may have to change to ensure balance.
  end

  # TODO: see about defaulting to the super Node class and getting
  # rid of all this cruft.
=begin
  def insert node, _parent = nil
    node < self ? insert_left(node, self) : insert_right(node, self)
  end

  def insert_left node, _parent
    @left.nil? ? @left = node : @left.insert(node, self)
  end

  def insert_right node, _parent
    @right.nil? ? @right = node : @right.insert(node, self)
  end
=end

  # TODO: see if this can punt to the parent Node class.
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
