# frozen_string_literal: true
require_relative './spec_helper'
require_relative '../lib/node'
require_relative './nodes'

require 'pry'

describe Node do
  include Nodes

  it 'instantiates' do
    expect(Node.new).not_to be_nil
  end

  describe '.insert' do
    it 'inserts left node' do
      node = Node.new 2
      left_node = Node.new 1
      node.add left_node
      expect(node.left).to eq left_node
    end

    it 'inserts right node' do
      node = Node.new 1
      right_node = Node.new 2
      node.add right_node
      expect(node.right).to eq right_node
    end
  end

  describe '.delete' do
    it 'returns the root node when specified for deletion' do
      root = Node.new(9)
      expect(root.delete(9)).to eq root
      expect(root.bst?).to be true
      expect(root.left.nil?).to be true
      expect(root.right.nil?).to be true
    end

    it 'deletes the right node specified by key' do
      root = Node.new(9)
      n14 = Node.new(14)
      root.add n14
      expect(root.delete(14)).to eq n14
      expect(root.bst?).to be true
      expect(n14.left.nil?).to be true
      expect(n14.right.nil?).to be true
    end

    it 'deletes a right node reassiging that nodes child' do
      root = Node.new(9)
      n14 = Node.new(14)
      n23 = Node.new(23)
      root.add n14
      root.add n23
      expect(root.delete(14)).to eq n14
      expect(root.bst?).to be true
      expect(n14.left.nil?).to be true
      expect(n14.right.nil?).to be true
      expect(root.right).to eq n23
      # expect(root.size).to eq 2
    end

    it 'reassigns right subtree on deletion' do
      root = Node.new(11)
      n17 = Node.new(17)
      n19 = Node.new(19)
      n13 = Node.new(13)
      n5 = Node.new(5)
      root.add n17
      root.add n19
      root.add n13
      root.add n5
      expect(root.delete(17)).to eq n17
      expect(root.bst?).to be true
      expect(n17.left.nil?).to be true
      expect(n17.right.nil?).to be true
      expect(root.right).to eq n19
      expect(root.right.left).to eq n13
    end

    it 'rebuilds subtree after deleting node' do
      root = Node.new(11)
      n5 = Node.new(5)
      root.add n5

      n17 = Node.new(17)
      n13 = Node.new(13)
      n41 = Node.new(41)
      n37 = Node.new(37)
      n31 = Node.new(31)
      root.add n17
      root.add n13
      root.add n41
      root.add n37
      root.add n31
      expect(root.delete(17)).to eq n17
      expect(root.bst?).to be true
      expect(n17.left.nil?).to be true
      expect(n17.right.nil?).to be true
      expect(root.right).to eq n41
      expect(n31.left).to eq n13
      # delete a leaf node
      expect(root.delete(13)).to eq n13
      expect(n31.left).to be nil
      # expect(root.size).to eq 5
    end

    it 'promotes left node on deletion' do
      root = Node.new(11)
      n5 = Node.new(5)
      n7 = Node.new(7)
      n3 = Node.new(3)
      root.add n5
      root.add n7
      root.add n3

      expect(root.delete(5)).to eq n5
      expect(root.bst?).to be true
      expect(n5.left.nil?).to be true
      expect(n5.right.nil?).to be true
      expect(root.left).to eq n3
      expect(n3.right).to eq n7
    end

    it 'deletes the root node correctly' do
      root = Node.new(11)
      n5 = Node.new(5)
      n7 = Node.new(7)
      n3 = Node.new(3)
      root.add n5
      root.add n7
      root.add n3

      n17 = Node.new(17)
      n13 = Node.new(13)
      n41 = Node.new(41)
      n37 = Node.new(37)
      n31 = Node.new(31)
      root.add n17
      root.add n13
      root.add n41
      root.add n37
      root.add n31

      expect(root.delete(11)).to eq root
      expect(root.left.nil?).to be true
      expect(root.right.nil?).to be true

      expect(n5.bst?).to be true
      expect(n5.left).to eq n3
      expect(n5.right).to eq n7
      expect(n7.right).to eq n17
    end
  end

  describe 'comparators' do
    it 'compares values with <' do
      node1 = Node.new(1)
      node2 = Node.new(2)
      expect(node1 < node2).to be true
    end

    it 'compares values with >=' do
      node1 = Node.new(1)
      node2 = Node.new(2)
      expect(node1 >= node2).to be false
    end

    it 'compares values with >' do
      node1 = Node.new(1)
      node2 = Node.new(2)
      expect(node1 > node2).to be false
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

  # require_relative 'shared_depth_examples'
  describe '.depth' do
    shared_examples "depth" do
      it 'finds the depth of single node tree' do
        node = Node.new(9)
        expect(node.depth).to eq 0
      end
    end

    it_has_behavior 'depth'

    it 'finds the depth of single node tree' do
      node = Node.new(9)
      expect(node.depth).to eq 0
    end

    it 'finds the depth of two node tree with right child' do
      node = Node.new(9)
      node.add Node.new(14)
      expect(node.depth).to eq 1
    end

    it 'finds the depth of two node tree with left child' do
      node = Node.new(9)
      node.add Node.new(4)
      expect(node.depth).to eq 1
    end

    it 'finds the depth of three node tree' do
      node = Node.new(9)
      node.add Node.new(14)
      node.add Node.new(4)
      expect(node.depth).to eq 1
    end

    it 'finds the depth of four node tree with two left children' do
      node = Node.new(9)
      node.add Node.new(14)
      node.add Node.new(4)
      node.add Node.new(2)
      expect(node.depth).to eq 2
    end

    it 'finds depth for arbitrary tree' do
      node = Node.new(9)
      node.add Node.new(14)
      node.add Node.new(4)
      node.add Node.new(23)
      node.add Node.new(5)
      node.add Node.new(99)
      node.add Node.new(78)
      expect(node.depth).to eq 4
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

  describe '.balanced?' do
    let(:root) { Node.new 100 }
    let(:left) { Node.new 50 }
    let(:right) { Node.new 150 }
    let(:l2) { Node.new 25 }
    let(:l3) { Node.new 75 }
    let(:l4) { Node.new 15 }

    it 'returns true for node with 0 children' do
      expect(root.balanced?).to be true
    end

    it 'returns true for node with 2 children' do
      root.add left
      root.add right
      expect(root.balanced?).to be true
    end

    it 'returns true for a node with only one child' do
      root.add left
      expect(root.balanced?).to be true
    end

    it 'returns true for tree with 5 nodes' do
      root.add left
      root.add right
      root.add l2
      root.add l3
      expect(root.balanced?).to be true
    end

    it 'returns nil for tree with 6 nodes' do
      root.add left
      root.add right
      root.add l2
      root.add l3
      root.add Node.new 145
      expect(root.balanced?).to be true
    end

    it 'returns false for long left subtree' do
      root.add left
      root.add right
      root.add l2
      root.add l3
      root.add l4
      root.add Node.new 5
      expect(root.balanced?).to be false
    end
  end

  describe '.bst?' do
    let(:root) { Node.new 100 }

    it 'returns true for tree with one node' do
      expect(root.bst?).to be true
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
