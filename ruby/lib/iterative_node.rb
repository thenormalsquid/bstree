# frozen_string_literal: true

require 'node'

class IterativeNode < Node
  def insert node
    current = self

    loop do
      if node < current
        current.left.nil? ? (current.left = node) && break : current = current.left
      else
        current.right.nil? ? (current.right = node) && break : current = current.right
      end
    end
  end

  # TODO: test these with this class
  def maximum
    max = self
    max = max.right while max.right
    max
  end

  # TODO: test these with this class
  def minimum
    min = self
    min = min.left while min.left
    min
  end
end
