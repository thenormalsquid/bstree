require_relative '../lib/node'
require_relative './nodes'

require 'pry'

describe Node do
  include Nodes

  it 'instantiates' do
    expect(Node.new).not_to be_nil
  end

  it 'adds left node' do
    node = Node.new 2
    left_node = Node.new 1
    node.add left_node
    expect(node.left).to eq left_node
  end

  it 'adds right node' do
    node = Node.new 1
    right_node = Node.new 2
    node.add right_node
    expect(node.right).to eq right_node
  end

  it 'adds node value' do
    value = 1
    node = Node.new(value)
    expect(node.value).to eq value
  end

  describe 'comparators' do
    it 'compares values with <' do
      node1 = Node.new(1)
      node2 = Node.new(2)
      expect(node1 < node2).to be true
    end
  end

  describe '.find' do
    it 'a single node finds a key' do
      node1 = Node.new 2
      node = node1.find 2
      expect(node.object_id).to eq node1.object_id
    end

    it 'finds a key on the left' do
      node1 = Node.new 2
      node2 = Node.new 1
      node1.add node2
      expect(node1.left).to eq node2
      expect(node1.find(1).object_id).to eq node2.object_id
    end

    it 'finds a key on the right' do
      node1 = Node.new 1
      node2 = Node.new 2
      node1.add node2
      expect(node1.right).to eq node2
      expect(node1.find(2).object_id).to eq node2.object_id
    end

    it 'finds a key on the right left' do
      node1 = Node.new 2
      node2 = Node.new 4
      node3 = Node.new 3
      node1.add node2
      node1.add node3
      expect(node1.right.left).to eq node3
      expect(node1.find(3).object_id).to eq node3.object_id
    end

    it 'finds a key on the left right' do
      node1 = Node.new 4
      node2 = Node.new 2
      node3 = Node.new 3
      node1.add node2
      node1.add node3
      expect(node1.left.right).to eq node3
      expect(node1.find(3).object_id).to eq node3.object_id
    end
  end

  describe '.to_a' do
    it 'returns an array of representing the node and children' do
      root = Node.new 3
      left = Node.new 2
      right = Node.new 4
      root.add left
      root.add right
      expected = [root.value, left.uuid, right.uuid]
      expect(root.to_a).to eq expected
    end

    it 'deals with leaf nodes correctly' do
      node1 = Node.new 4
      node2 = Node.new 2
      node3 = Node.new 3
      node1.add node2
      node1.add node3
      expected = [node1.value, node2.uuid, nil]
      expect(node1.to_a).to eq expected
    end
  end
end
