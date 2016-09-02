# frozen_string_literal: true
require 'securerandom'
require 'csv'

class NodeCsvWriter
  def initialize node
    [node.value, node.left.uuid, node.right.uuid]
  end
end

class Node
  attr_accessor :left, :right, :uuid
  attr_accessor :value

  INCR = 1
  DECR = -1

  def initialize value = nil, uuid = nil
    @value = value
    @uuid = uuid || SecureRandom.uuid
  end

  def < other
    @value < other.value
  end

  def >= other
    @value >= other.value
  end

  def > other
    @value > other.value
  end

  def insert node
    node < self ? insertleft(node) : insertright(node)
  end

  def insertleft node
    @left.nil? ? @left = node : @left.insert(node)
  end

  def insertright node
    @right.nil? ? @right = node : @right.insert(node)
  end

  def get_successor node, parent, successor
    successor = parent&.left == self ? parent : successor
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
    return [self, parent] if key == value
    key < value ? left&.find_with_parent(key, self) : right&.find_with_parent(key, self)
  end

  def find key
    return self if key == value
    key < value ? left&.find(key) : right&.find(key)
  end

  def present? key
    return true if key == value
    key < value ? left&.present?(key) : right&.present?(key)
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
    left&.full? && right&.full? # returns nil instead of false, why?
  end

  def bst?
    return false if (left&.>= self) || (right&.< self)
    true
  end

  def maximum
    right&.maximum || self
  end

  def minimum
    left&.minimum || self
  end

  def self.build_from_hash params
    return nil if params.nil?
    node = new(params['value'], params['uuid'])
    node.left = build_from_hash(params['left'])
    node.right = build_from_hash(params['right'])
    node
  end

  def to_hash
    {
      'value' => value,
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
    [value, @left&.uuid, @right&.uuid]
  end
end
