# frozen_string_literal: true

require 'tree'
require 'avl_node'

class AvlTree < Tree
  def initialize node
    super
    root.balance_factor = 0
  end

  def insert node
    super
    retrace node
  end

  def rotate_left node, rotation_root
    if node.balance_factor < 0
      node.rotate_right
      node.balance_factor += 1
      node = rotation_root.right
      node.balance_factor += 1
    end
    pivot = rotation_root.rotate_left
    # ^^^^ This is correct for the rotations on a right chain.
    rotation_root.balance_factor -= 1
    pivot.balance_factor -= 1
    @root = pivot if @root == rotation_root
    pivot.parent
  end

  def rotate_right node, parent
    if node.balance_factor > 0
      node.rotate_left
      node.balance_factor -= 1
      node = parent.left
      node.balance_factor -= 1
    end
    parent.rotate_right
    parent.balance_factor += 1
    @root = node if @root == parent
    node
  end

  def balance_right node
    parent = node.parent
    # parent.balance_factor > 0 ?  rotate_left(node, parent) : parent.balance_factor += 1
    return rotate_left(node, parent) if parent.balance_factor > 0
    parent.balance_factor += 1
    node.parent
  end

  def balance_left node
    parent = node.parent
    # parent.balance_factor < 0 ?  rotate_right(node, parent) : parent.balance_factor -= 1
    return rotate_right(node, parent) if parent.balance_factor < 0
    parent.balance_factor -= 1
    node.parent
  end

  def balance node
    node.right_child? ? balance_right(node) : balance_left(node)
  end

  def retrace node
    # binding.pry if node.key == 6
    parent = node.parent
    while !parent.nil?
      # we need get the current node here, because the node which
      # gets rotated has it's parent reset, which gums everything up.
      node = balance(node)
      # node = parent
      parent = node&.parent
    end
  end
end
