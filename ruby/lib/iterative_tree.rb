require 'tree'

class IterativeTree < Tree
  # TODO: implement inorder_iterate without a stack,
  # using pointer equality.
  # TODO: move this method to an IterativeTree class.
  def inorder_iterate
    output = []
    stack = [root]

    stack << stack.last.left while stack.last&.left

    until stack.empty?
      current = stack.pop
      output << current&.key
      next unless current&.right

      stack << current.right
      stack << stack.last.left while stack.last&.left
    end
    output.compact
  end
  # TODO: try implementing with has_unvisited_child?
  # and writing out the key before setting to child
  # node. The node is set to visited as soon as the
  # key is written.
  def preorder_iterate
    output = []
    return output unless root

    stack = [root]
    current = stack.last
    output << current.key

    until current&.left.nil?
      current = current.left
      output << current.key
      stack.push current
    end

    until stack.empty?
      current = stack.pop

      unless current&.right.nil?
        current = current.right
        stack.push current
        output << current.key
        while stack.last&.left
          stack << stack.last.left
          output << stack.last.key
        end
      end
    end
    output.compact
  end

  # TODO: consider making this static
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

  # TODO: consider making this static
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

  def postorder_iterate
    output = []
    return output unless root

    # TODO: use do-while if possible.
    current = find_unvisited_leaf_node root
    output << current.key

    while current.has_parent?
      current = find_unvisited_leaf_node current.parent
      output << current.key
    end
    output
  end
end
