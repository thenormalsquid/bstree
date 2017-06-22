# frozen_string_literal: true

require 'tree'
require 'avl_node'

# This may or may not be a temporary class,
# the regular Tree may be able to handle an AvlNode,
# but it's confusing me to think about it right now.
# I'm focusing on getting the rotations implemented
# correctly, and subclassing here reduces distraction.
class AvlTree < Tree
  def insert node
    super
    rebalance node
  end

  def rebalance node
    x = node.parent
    g = x.parent
    if node.left_child?
      'left'
      else
      'right'
    end
  end
end
