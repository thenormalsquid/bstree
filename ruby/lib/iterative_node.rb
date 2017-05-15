# frozen_string_literal: true

require 'node'

class IterativeNode < Node
  def insert node
    current = self

    loop do
      if node < current
        current.left.nil? ? insert_left(current, node) && break : current = current.left
      else
        current.right.nil? ? insert_right(current, node) && break : current = current.right
      end
    end
  end

  def insert_left current, node
    node.parent = current
    current.left = node
  end

  def insert_right current, node
    node.parent = current
    current.right = node
  end

  def maximum
    max = self
    max = max.right while max.right
    max
  end

  def minimum
    min = self
    min = min.left while min.left
    min
  end
end
