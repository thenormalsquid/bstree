require 'securerandom'
require 'csv'

class NodeCsvWriter
  def initialize(node)
    [node.value, node.left.uuid, node.right.uuid]
  end
end

class Node
  attr_reader :left, :right, :uuid
  attr_accessor :value

  def initialize value = nil
    @value = value
    @uuid = SecureRandom.uuid
  end

  def < other
    @value < other.value
  end

  def add node
    node < self ? addleft(node) : addright(node)
  end

  def addleft node
    @left.nil? ? @left = node : @left.add(node)
  end

  def addright node
    @right.nil? ? @right = node : @right.add(node)
  end

  def find key
    return self if key == value
    key < value ? left&.find(key) : right&.find(key)
  end

  def to_a
    [value, @left&.uuid, @right&.uuid]
  end
end
