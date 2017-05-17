require 'tree'

class IterativeTree < Tree
  # TODO: some interesting API work here. We want to
  # be able to test the implementations for traversing
  # the tree pre-order, in-order and post-order, but the
  # interface, that is, the method call must be the
  # same for this case which iterates and the parent
  # class which calls the root node to recurse.
  # So we'll want the following in both this class
  # and the parent class:
  def preorder_walk &block
    preorder_iterate(&block)
  end

  def inorder_walk &block
    inorder_iterate(&block)
  end

  def postorder_walk &block
    postorder_iterate(&block)
  end

  # TODO: all of these really need to accept callbacks,
  # but maybe not this next rev.

  # TODO: implement inorder_iterate without a stack,
  # using pointer equality.
  def inorder_iterate
    # output = []
    stack = [root]

    stack << stack.last.left while stack.last&.left

    until stack.empty?
      current = stack.pop
      # output << current&.key
      yield current
      next unless current&.right

      stack << current.right
      stack << stack.last.left while stack.last&.left
    end
    # output.compact
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
    # output = []
    # return output unless root
    return unless root

    stack = [root]
    current = stack.last
    # output << current.key
    yield current

    until current&.left.nil?
      current = current.left
      # output << current.key
      yield current
      stack.push current
    end

    until stack.empty?
      current = stack.pop

      unless current&.right.nil?
        current = current.right
        stack.push current
        # output << current.key
        yield current
        while stack.last&.left
          stack.push stack.last.left
          # output << stack.last.key
          yield stack.last
        end
      end
    end
    # output.compact
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
