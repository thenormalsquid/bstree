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

  def collect collector
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

  def inorder_iterate
    output = []
    stack = [root]

    while stack.last&.left
      stack << stack.last.left
    end

    while !stack.empty?
      current = stack.pop
      output << current&.key
      if current&.right
        stack << current.right
        while stack.last&.left
          stack << stack.last.left
        end
      end
    end
    output.compact
  end

  def preorder_iterate
    output = []
    return output unless root

    stack = [root]
    current = stack.last
    output << current.key

    while current&.left != nil
      current = current.left
      output << current.key
      stack.push current
    end

    while !stack.empty?
      current = stack.pop

      if current&.right != nil
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

  require 'ap'
  def postorder_iterate
    output = []
    return output unless root

    current = find_leaf_node root
    output << current.key
    current.visited = true
    current = current.parent if current.parent

    current = find_leaf_node current.right



=begin
    current = root

    # Pure parent implementation

    # I think what I need to do is find a leaf node, that is, a node with
    # both children nil, then work my way backwards via parent pointers.
    # I don't even know how to find a leaf node at the moment.
    #
    # A related problem might be to find the deepest leaf node. Recursively,
    # that should be pretty easy, think.

    if current.left
      current = find_leaf_node current.left
      output << current.key
      if current == current.parent.right
        current = current.parent
        output << current.key
      end
    end

    current = root

    if current.right
      current = find_leaf_node current.right
      output << current.key
      if current == current.parent.right
        current = current.parent
        output << current.key
      elsif current == current.parent.left
        current = current.parent
        # output << current.key
        # check right child for leaf nodes
      end
    end

    output << root.key

    return output.compact
=end

=begin
    stack = [root]
    current = stack.last

    # while current&.left != nil
    #   current = current.left
    #   stack.push current
    # end

    while current.has_children?
      if current.left
        current = current.left
      elsif current.right
        current = current.right
      end
      stack.push current if current.has_children?
    end

    # binding.pry

    while !stack.empty?
      # binding.pry
      current = stack.pop

      # if current&.right != nil && !current&.right.visited?
      if current&.left != nil && !current&.left.visited?
        stack.push current
        # current = current.right
        current = current.left
        stack.push current if current.has_children?
        # while stack.last&.left
        #   stack << stack.last.left
        # end
        while stack.last&.right
          stack << stack.last.right
        end
      # output << current.key
      end

      current.visited = true
      output << current.key
      # current = stack.pop
    end
=end

=begin
    while stack.last&.left
      stack << stack.last.left
    end
    current = stack.last


    # We want to keep 17 and 29 on the stack until 19 and 43
    # have been written out. Let's do it explicitly.

    # while !stack.empty?
    while current

      # TODO: delete once working
      iteration += 1
      break if iteration > 8

      if current&.right
        stack << current.right # push 43
        current = current.right
        while current&.left # nothing
          current = current.left
          stack << current
        end
        current = stack.pop # pop 43
        output << current.key # write 43
      end
      current = stack.pop # pop 29
      output << current.key if current
    end
=end

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
