# frozen_string_literal: true
require_relative './node'

class Tree
  attr_reader :root, :size

  def initialize node = nil
    @root = node ? node : Node.new
    @size = 1
  end

  def add node
    @root.add node
    @size += 1
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

  def depth
    @max = 0
    @current = 0
    find_depth root
  end

  def find_depth node
    return if node.nil?

    @current += 1
    find_depth node.left
    find_depth node.right
    @current -= 1
    @max = @max < @current ? @current : @max
  end

  def full?
    root.full?
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
