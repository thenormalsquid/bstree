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
    node.weight = 0
    node.balance_factor = 0
    retrace node
  end

  def balance_right node
    parent = node.parent

    if parent.balance_factor > 0
      parent.rotate_left
      @root = node if @root == parent
    else
      parent.balance_factor += 1
    end
  end

  def balance_left node
    parent = node.parent

    if parent.balance_factor < 0
      parent.rotate_right
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
