# frozen_string_literal: true
module BinarySearchTree
  attr_accessor :left, :right

  def < _other
    raise NoMethodError.new "'<' method must be overridden"
  end

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

  def size
    size = 0
    post_order_traverse { size += 1 }
    size
  end

  def post_order_traverse &block
    left&.post_order_traverse(&block)
    right&.post_order_traverse(&block)
    yield
  end

  # Figure out whether there is any way to subclass to_hash
  # such the @uuid and @key is set in the subclass, that is,
  # the including class. That would make this a bit cleaner,
  # it's always nasty having a subclass attribute instance
  # referenced by the module.
  def to_hash
    {
      uuid: @uuid,
      key: @key,
      left: left&.to_hash,
      right: right&.to_hash
    }
  end
end
