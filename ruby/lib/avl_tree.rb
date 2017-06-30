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
    rebalance node
  end

  def reset_right_balance node, parent
    if parent.balance_factor > 0
      parent.rotate_ccw
      @root = node if @root == parent
    else
      parent.balance_factor += 1
    end
  end

  def reset_left_balance node, parent
    if parent.balance_factor < 0
      parent.rotate_cw
      @root = node if @root == parent
      parent.balance_factor += 1
    else
      parent.balance_factor -= 1
    end
  end

  def reset_balances node, parent
    if node.right_child?
      reset_right_balance(node, parent)
    else
      reset_left_balance(node, parent)
    end
  end

  def rebalance node
    parent = node.parent
    while !parent.nil?
      reset_balances(node, parent)
      node = parent
      parent = node.parent
    end
  end
end
