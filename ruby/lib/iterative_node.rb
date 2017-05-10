require 'node'

class IterativeNode < Node
  def insert node
    current = self

    while true
      if node < current
        if current.left.nil?
          current.left = node and break
        else
          current = current.left
        end
      else
        if current.right.nil?
          current.right = node and break
        else
          current = current.right
        end
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
