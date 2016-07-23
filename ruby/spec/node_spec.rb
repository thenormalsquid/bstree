# frozen_string_literal: true
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

  describe 'present?' do
    it 'indicates whether a node is present' do
      root = Node.new 4
      node2 = Node.new 2
      node3 = Node.new 3
      node4 = Node.new 9
      root.add node2
      root.add node3
      root.add node4
      expect(root.present?(4)).to eq true
      expect(root.present?(2)).to eq true
      expect(root.present?(3)).to eq true
      expect(root.present?(9)).to eq true
      expect(root.present?(8)).to eq nil
    end
  end

  describe '.full?' do
    let(:root) { Node.new 100 }
    let(:left) { Node.new 50 }
    let(:right) { Node.new 150 }
    let(:l2) { Node.new 25 }
    let(:l3) { Node.new 75 }

    it 'returns true for node with 0 children' do
      expect(root.full?).to be true
    end

    it 'returns true for node with 2 children' do
      root.add left
      root.add right
      expect(root.full?).to be true
    end

    it 'returns false for a node with only one child' do
      root.add left
      expect(root.full?).to be nil
    end

    it 'returns true for tree with 5 nodes' do
      root.add left
      root.add right
      root.add l2
      root.add l3
      expect(root.full?).to be true
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

  describe '.to_hash' do
    it 'creates a hash of the tree' do
      node = Node.new(8)
      nodel = Node.new(4)
      noder = Node.new(14)
      node.add nodel
      node.add noder

      expected = {
        'value' => node.value,
        'uuid' => node.uuid,
        'left' => {
          'value' => nodel.value,
          'uuid' => nodel.uuid,
          'left' => nil,
          'right' => nil
        },
        'right' => {
          'value' => noder.value,
          'uuid' => noder.uuid,
          'left' => nil,
          'right' => nil
        }
      }

      expect(node.to_hash).to eq expected
    end
  end

  describe 'build_from_hash' do
    it 'builds a tree from a root node nested hashes' do
      node = Node.new(8)
      new_node = Node.build_from_hash node.to_hash
      expect(new_node.uuid).to eq node.uuid
      expect(new_node.value).to eq node.value
    end

    it 'builds a tree from a root node nested hashes' do
      root = Node.new(8)
      left = Node.new(4)
      right = Node.new(14)
      root.add left
      root.add right
      new_node = Node.build_from_hash root.to_hash
      expect(new_node.uuid).to eq root.uuid
      expect(new_node.value).to eq root.value
      expect(new_node.left.uuid).to eq left.uuid
      expect(new_node.left.value).to eq left.value
      expect(new_node.right.uuid).to eq right.uuid
      expect(new_node.right.value).to eq right.value
    end
  end

  describe '.to_json' do
    it 'creates a json representation of the node' do
      node = Node.new(8)
      allow(node).to receive(:uuid).and_return('uuid')
      expected = "{\"value\":8,\"uuid\":\"uuid\",\"left\":null,\"right\":null}"
      expect(node.to_json).to eq expected
    end
  end
end
