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

  def present? key
    return true if key == value
    key < value ? left&.present?(key) : right&.present?(key)
  end

  def full?
    return true if left.nil? && right.nil?
    left&.full? && right&.full? # returns nil instead of false, why?
  end

  def bst?
    return false if (left &.>= self) || (right &.< self)
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
