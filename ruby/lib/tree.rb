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
  def transplant u, v
    if u.parent == nil # u is a root node
      @root = v
    elsif u == u.parent.left # u is a left child of its parent
      u.parent.left = v
    else # u is a right child of its parent
      u.parent.right = v
    end

    if v != nil
      v.parent = u.parent
    end
    v
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

  # Another attempt at rational delete implementation, using
  # node successor for two child nodes instead of inserting the
  # orphaned subtree.
  def delete_by_key key
    node = search key
    left = node.left
    right = node.right
    parent = node.parent

    # Case with 2 children. Swap the actual nodes instead of copying data
    # from one node to the next. This allows better node and tree management.
    if left && right
      puts "two children"
      s = successor(node)
      successor_parent = s.parent
      successor_right = s.right
      @root = s if parent == nil

      if parent&.left == node
        puts "parent.left"
        parent&.left = s

        s.parent = parent
        s.right = right unless node.right == s
        s.left = left
        right.parent = s

        node.left.parent = s

        successor_right&.parent = successor_parent
        successor_parent.left = successor_right
      else
        puts "parent.right"
        parent&.right = s

        s.parent = parent
        s.right = right unless node.right == s
        s.left = left
        right.parent = s

        # left.parent = s
        left.parent = s

        successor_right&.parent = successor_parent
        successor_parent.left = successor_right
      end

      @size -= 1
      node.left = node.right = node.parent = nil
      return node
    end

    # Case with no children
    if left.nil? && right.nil?
      if parent.nil?
        @root = nil
        @size -= 1
        node.left = node.right = node.parent = nil
        return node
      end

      if parent.left == node
        parent.left = nil
      else
        parent.right = nil
      end
      @size -= 1
      node.left = node.right = node.parent = nil
      return node
    end

    # Case with only left child
    if left && right.nil?
      if parent.left == node
        parent.left = node.left
      else
        parent.right = node.left
      end
      @size -= 1
      node.left = node.right = node.parent = nil
      return node
    end

    # Case with only right child
    if node.right && node.left.nil?
      if parent.left == node
        parent.left = node.right
      else
        parent.right = node.right
      end
      @size -= 1
      node.left = node.right = node.parent = nil
      return node
    end
  end

  def list_keys
    root&.list_keys or []
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
      # file.write to_json
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

  def get_next_row current_row
    next_row = []
    current_row.each do |node|
      next_row << node.left
      next_row << node.right
    end
    next_row.compact
  end

  def bfsearch
    rows = [[root]]
    rows << get_next_row(rows.last) until rows.last.empty?
    rows.flatten.map(&:key)
  end
end
