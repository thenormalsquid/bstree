# frozen_string_literal: true

require_relative './node'
require 'pry'

class Tree
  attr_reader :root, :size

  def initialize node = nil
    @root = node ? node : Node.new
    @size = 1
  end

  def empty?
    root.nil? ? true : false
  end

  def insert node
    @root.insert node
    @size += 1
  end

  # From CLRS (3rd Edition) p. 296, "transplant" a node's
  # location in the tree. The idea is to replace u with v.
  # This function would be better named `reset_parent` because
  # that's all it does. Resetting child links is done in the
  # delete method.
  def transplant u, v
    # Consider "ruby-izing the following. Rubocop doesn't like it.
    if u.parent.nil? # u is a root node
      @root = v
    elsif u == u.parent.left # u is a left child of its parent
      u.parent.left = v
    else # u is a right child of its parent
      u.parent.right = v
    end

    # if !v.nil?
    v&.parent = u.parent
    # v.parent = u.parent unless v.nil?
    # end
    v
  end

  def delete_clrs3 key
    z = search key
    if z.left.nil?
      transplant z, z.right
    elsif z.right.nil?
      transplant z, z.left
    else
      y = z.right.minimum
      if y.parent != z
        transplant y, y.right
        y.right = z.right
        y.right.parent = y
      end
      transplant z, y
      y.left = z.left
      y.left.parent = y
    end
    @size -= 1
    z.left = z.right = z.parent = nil
    z
  end

  # This is kind of nasty. It turns out that rooting a tree
  # in some sort of container is both a crutch and a constraint.
  # The big hassle is the edge case induced by deleting the root
  # node.
  def delete key
    left = @root.left
    right = @root.right
    deleted_node = @root.delete key
    @size -= 1
    # This is arbitrary, we just pick a side.
    @root = left || right if deleted_node == @root
    deleted_node
  end

  def delete_by_key key
    delete_clrs3 key
  end

  def list_keys
    root&.list_keys || []
  end

  def collect _collector
    root&.collect [] || []
  end

  def search key
    @root.find key
  end

  def height
    root.nil? ? 0 : root.height
  end

  def full?
    root.full?
  end

  def bst?
    root.bst?
  end

  def successor node
    root.successor node
  end

  def predecessor node
    root.predecessor node
  end

  def maximum
    @root.maximum
  end

  def minimum
    @root.minimum
  end

  def to_hash
    root.to_hash
  end

  def to_json
    root.to_json
  end

  def to_json_file filename
    File.open(filename, 'w') do |file|
      file.write root.to_json
    end
  end

  def self.from_json_file filename
    require 'json'
    file = File.read(filename)
    hash = JSON.parse(file)
    from_hash(hash)
  end

  def self.from_hash hash
    Tree.new(Node.build_from_hash(hash))
  end

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

  def get_next_row current_row
    next_row = []
    current_row.each do |node|
      next_row << node.left
      next_row << node.right
    end
    next_row.compact
  end

  # TODO: rename to breadth_first_traverse
  def bfsearch
    rows = [[root]]
    rows << get_next_row(rows.last) until rows.last.empty?
    rows.flatten.map(&:key)
  end
end
