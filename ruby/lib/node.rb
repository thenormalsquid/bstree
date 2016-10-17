# frozen_string_literal: true
require 'securerandom'
require 'csv'

class NodeCsvWriter
  def initialize node
    [node.key, node.left.uuid, node.right.uuid]
  end
end

class Node
  attr_accessor :parent, :left, :right, :uuid
  attr_accessor :key

  INCR = 1
  DECR = -1

  def initialize key = nil, uuid = nil
    @key = key
    @uuid = uuid || SecureRandom.uuid
  end

  def < other
    @key < other.key
  end

  def >= other
    @key >= other.key
  end

  def > other
    @key > other.key
  end

  def insert node
    node < self ? insert_left(node) : insert_right(node)
  end

  def insert_left node
    if @left.nil?
      node.parent = self
      @left = node
    else
      @left.insert(node)
    end
  end

  def insert_right node
    if @right.nil?
      node.parent = self
      @right = node
    else
      @right.insert(node)
    end
  end

  def get_predecessor node, parent, predecessor
    predecessor = parent if parent&.right == self
    return left.nil? ? predecessor : left.maximum if node == self

    if node < self
      left&.get_predecessor node, self, predecessor
    else
      right&.get_predecessor node, self, predecessor
    end
  end

  def predecessor node
    get_predecessor node, self, node
  end

  def get_successor node, parent, successor
    successor = parent if parent&.left == self
    return right.nil? ? successor : right.minimum if node == self

    if node < self
      left&.get_successor node, self, successor
    else
      right&.get_successor node, self, successor
    end
  end

  def successor node
    get_successor node, self, node
  end

  def self.max l, r
    l > r ? l : r
  end

  def height
    raise if left && left == self || right && right == self # stack overflow
    self.class.max(left&.height || -1, right&.height || -1) + 1
  end

  def delete key, parent = nil
    node_to_delete, parent = find_with_parent key, parent
    left = node_to_delete.left
    right = node_to_delete.right

    if parent&.right == node_to_delete
      parent&.right = right
      right.insert left unless left.nil?
    else
      parent&.left = left
      left.insert right unless right.nil?
    end

    node_to_delete.left = node_to_delete.right = nil
    node_to_delete
  end

  def find_with_parent key, parent
    return [self, parent] if key == @key
    key < @key ? left&.find_with_parent(key, self) : right&.find_with_parent(key, self)
  end

  def find key
    return self if key == @key
    key < @key ? left&.find(key) : right&.find(key)
  end

  def present? key
    return true if key == @key
    key < @key ? left&.present?(key) : right&.present?(key)
  end

  def balanced?
    left_height = left&.height || 0
    right_height = right&.height || 0
    return false unless [-1, 0, 1].include?(left_height - right_height)
    left&.balanced?
    right&.balanced?
    true
  end

  def full?
    return true if left.nil? && right.nil?
    left&.full? && right&.full? || false # returns nil instead of false, why?
  end

  def bst?
    minimum = -10000 # fixme
    in_order_traverse do |node|
      return false if minimum >= node.key
      minimum = node.key
      true
    end
  end

  def maximum
    right&.maximum || self
  end

  def minimum
    left&.minimum || self
  end

  def collect collector
    in_order_traverse { |node| collector << node.key }
  end

  def list_keys
    collect []
  end

  def in_order_traverse &block
    left&.in_order_traverse(&block)
    result = yield(self)
    right&.in_order_traverse(&block)
    result
  end

  def self.build_from_hash params
    return nil if params.nil?
    node = new(params['key'], params['uuid'])
    node.left = build_from_hash(params['left'])
    node.right = build_from_hash(params['right'])
    node
  end

  def to_hash
    {
      'key' => key,
      'uuid' => uuid,
      'left' => left&.to_hash,
      'right' => right&.to_hash
    }
  end

  def to_json
    require 'json'
    to_hash.to_json
  end

  def to_a
    [key, @left&.uuid, @right&.uuid]
  end
end
