# frozen_string_literal: true
require_relative './node'
require 'pry'

class Tree
  attr_reader :root, :size

  INCR = 1
  DECR = -1

  def initialize node = nil
    @root = node ? node : Node.new
    @size = 1
  end

  def add node
    @root.add node
    @size += 1
  end

  # This is kind of nasty. It turns out that rooting a tree
  # in some sort of container is both a crutch and a constraint.
  # The big hassle is the edge case induced by deleted the root
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

  def collect
    collector = []
    get_values @root, collector
    collector
  end

  def get_values node, collector
    get_values node.left, collector if node.left
    collector << node.value
    get_values node.right, collector if node.right
  end

  def find key
    @root.find key
  end

  # TODO: move this into the node class.
  def depth
    max = 0
    current = 0
    find_depth root do |increment|
      current += increment
      max = max < current ? current : max unless increment == INCR
    end
    max
  end

  def find_depth node, &block
    return if node.nil?
    yield(INCR)
    find_depth node.left, &block
    find_depth node.right, &block
    yield(DECR)
  end

  def full?
    root.full?
  end

  def bst?
    root.bst?
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
    File.open(filename, 'w') do |f|
      f.write root.to_json
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
    rows.flatten.map(&:value)
  end
end
