require 'node'

class IterativeNode < Node
  def insert node
    current = node
    while true
      if current < self
        if self.left.nil?
          self.left = current
          break
        else
          current = current.left
          # next
        end
      else
        if self.right.nil?
          self.right = current
          break
        else
          current = current.right
          # next
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
