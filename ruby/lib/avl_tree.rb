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

  def balance_right node
    parent = node.parent

    if parent.balance_factor > 0
      if node.balance_factor < 0
        node.rotate_right
        node.balance_factor += 1
        node = parent.right
        node.balance_factor += 1
        parent.rotate_left
      else
        parent.rotate_left
      end
      parent.balance_factor -= 1
      @root = node if @root == parent
    else
      parent.balance_factor += 1
    end
  end

  def balance_left node
    parent = node.parent

    if parent.balance_factor < 0
      if node.balance_factor > 0
        node.rotate_left
        node.balance_factor -= 1
        node = parent.left
        node.balance_factor -= 1
        parent.rotate_right
      else
        parent.rotate_right
      end
      parent.balance_factor += 1
      @root = node if @root == parent
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
