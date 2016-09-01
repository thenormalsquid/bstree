# frozen_string_literal: true
module BinarySearchTree
  attr_accessor :left, :right

  INCR = 1
  DECR = -1

  def < _other
    raise NoMethodError.new "'<' method must be overridden"
  end

  def insert node
    if node < self
      left.nil? ? self.left = node : left.insert(node)
    else
      right.nil? ? self.right = node : right.insert(node)
    end
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

  def self.max l, r
    l > r ? l : r
  end

  def height
    BinarySearchTree.max(left&.height || -1, right&.height || -1) + 1
  end

  # see if this can be rewritten with `dig` below
  def find_with_parent key, parent
    return [self, parent] if key == @key
    key < @key ? left&.find_with_parent(key, self) : right&.find_with_parent(key, self)
  end

  def collect collector
    left&.collect collector
    collector.push @key
    right&.collect collector
  end

  # TODO: rewrite this using `dig` below
  def common_parent n1, n2
    # Probably should enforce n1 < n2 with a swap if necessary.
    if n1 < n2
      l = n1
      r = n2
    else
      l = n2
      r = n1
    end

    return self if l <= self && self <= r
    l < self ? left&.common_parent(l, r) : right&.common_parent(l, r)
  end

  def find key
    return self if @key == key
    key < @key ? left&.find(key) : right&.find(key)
  end

  def present? key
    return true if key == @key
    key < @key ? left&.present?(key) : right&.present?(key)
  end

  def dig key, &block
    yield(self)
    key < @key ? left&.dig(key, &block) : right&.dig(key, &block)
  end

  def find key
    dig(key) { |n| return n if n.key == key }
  end

  def present? key
    dig(key) { |n| return true if n.key == key }
  end

  # Easy, dumb way to do it.
  def bst?
    return false if left && left >= self || right && self > right
    left&.bst?
    right&.bst?
    true
  end

  # This is what is tested.
  def bst?
    pre_order_traverse { (left &.>= self) || (right &.< self) ? false : true }
  end

  def maximum
    right&.maximum || self
  end

  def minimum
    left&.minimum || self
  end

  def destroy
    post_order_traverse do |node|
      node.left = nil
      node.right = nil
    end
  end

  def size
    size = 0
    post_order_traverse { size += 1 }
    size
  end

  def pre_order_traverse &block
    result = yield
    left&.pre_order_traverse(&block)
    right&.pre_order_traverse(&block)
    result
  end

  def post_order_traverse &block
    left&.post_order_traverse(&block)
    right&.post_order_traverse(&block)
    yield(self)
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
