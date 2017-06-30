# frozen_string_literal: true

require 'tree'
require 'avl_node'

# This may or may not be a temporary class,
# the regular Tree may be able to handle an AvlNode,
# but it's confusing me to think about it right now.
# I'm focusing on getting the rotations implemented
# correctly, and subclassing here reduces distraction.
class AvlTree < Tree
  def initialize node
    super
    root.balance_factor = 0
  end

  def insert node
    super
    node.weight = 0
    node.balance_factor = 0
    retrace node
  end

  def balance_right node
    parent = node.parent

    if parent.balance_factor > 0
      parent.rotate_ccw
      @root = node if @root == parent
    else
      parent.balance_factor += 1
    end
  end

  def balance_left node
    parent = node.parent

    if parent.balance_factor < 0
      parent.rotate_cw
      @root = node if @root == parent
      parent.balance_factor += 1
    else
      parent.balance_factor -= 1
    end
  end

  def balance node
    if node.right_child?
      balance_right node
    else
      balance_left node
    end
  end

  def retrace node
    parent = node.parent
    while !parent.nil?
      balance node
      node = parent
      parent = node.parent
    end
  end
end
