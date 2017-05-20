require 'tree'
require 'iterative_node'

class IterativeTree < Tree
  NODE_CLASS = IterativeNode

  def preorder_walk
    preorder_iterate(&Proc.new)
  end

  def inorder_walk
    inorder_iterate(&Proc.new)
  end

  def postorder_walk
    postorder_iterate(&Proc.new)
  end

  # TODO: implement inorder_iterate without a stack,
  # using pointer equality.
  def inorder_iterate
    stack = [root]
    stack << stack.last.left while stack.last&.left

    until stack.empty?
      current = stack.pop
      yield current
      next unless current&.right

      stack << current.right
      stack << stack.last.left while stack.last&.left
    end
  end

  def postorder_iterate &block
    return unless root

    current = find_unvisited_leaf_node root
    yield current

    while current.has_parent?
      current = find_unvisited_leaf_node current.parent
      yield current
    end
  end

  def preorder_iterate
    return unless root

    stack = [root]
    current = stack.last
    yield current

    until current&.left.nil?
      current = current.left
      yield current
      stack.push current
    end

    until stack.empty?
      current = stack.pop

      unless current&.right.nil?
        current = current.right
        stack.push current
        yield current
        while stack.last&.left
          stack.push stack.last.left
          yield stack.last
        end
      end
    end
  end

  def find_leaf_node current
    while current.has_children?
      if current.left
        current = current.left
      elsif current.right
        current = current.right
      end
    end
    current
  end

  def find_unvisited_leaf_node current
    while current.has_unvisited_children?
      if current.left&.unvisited?
        current = current.left
      elsif current.right&.unvisited?
        current = current.right
      end
    end
    current.visit
  end
end
