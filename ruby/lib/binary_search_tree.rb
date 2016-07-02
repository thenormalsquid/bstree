# frozen_string_literal: true
module BinarySearchTree
  attr_accessor :left, :right

  def add node
    if node < self
      left.nil? ? self.left = node : left.add(node)
    else
      right.nil? ? self.right = node : right.add(node)
    end
  end

  def collect collector
    left&.collect collector
    collector.push @key
    right&.collect collector
  end

  def find key
    return self if @key == key
    key < @key ? left&.find(key) : right&.find(key)
  end

  def present? key
    return true if key == @key
    key < @key ? left&.present?(key) : right&.present?(key)
  end

  def maximum
    right&.maximum || self
  end

  def minimum
    left&.minimum || self
  end

  def to_hash
    {
      uuid: @uuid,
      left: left&.to_hash,
      right: right&.to_hash
    }
  end
end
