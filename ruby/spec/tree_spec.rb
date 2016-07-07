# frozen_string_literal: true
require_relative '../lib/tree.rb'
require_relative '../lib/node.rb'

describe Tree do
  it 'instantiates correctly' do
    expect(Tree.new).not_to be_nil
  end

  it 'instantiates a root node' do
    node = Node.new
    expect(tree = Tree.new(node)).not_to be_nil
    expect(tree.root).to eq node
  end

  describe '.size' do
    it 'adds a node to the tree with existing root' do
      node = Node.new(1)
      tree = Tree.new node
      node2 = Node.new(2)
      tree.add node2
      expect(tree.size).to eq 2

      node3 = Node.new(3)
      tree.add node3
      expect(tree.size).to eq 3
    end
  end

  describe 'tree structure' do
    it 'adds a node to the tree with existing root' do
      node = Node.new(10)
      tree = Tree.new node
      tree.add Node.new(2)
      expect(tree.size).to eq 2
      expect(tree.root.left.value).to eq 2

      tree.add Node.new(33)
      expect(tree.size).to eq 3
      expect(tree.root.right.value).to eq 33

      tree.add Node.new(23)
      expect(tree.size).to eq 4
      expect(tree.root.right.left.value).to eq 23
    end
  end

  describe '.find' do
    it 'finds a node with given key' do
      node = Node.new(9)
      tree = Tree.new node
      tree.add Node.new(14)
      tree.add Node.new(4)
      tree.add Node.new(23)
      tree.add Node.new(5)
      tree.add Node.new(99)
      target = Node.new(77)
      tree.add target
      expect(tree.size).to eq 7
      expect(tree.find(77).object_id).to eq target.object_id
    end
  end

  describe 'depth of tree' do
    # Depth should be incremented when nodes are added,
    # if the depth is to be considered as an attribute of the tree.
    # As a virtual attribute (to borrow a notion from Ruby), calling a
    # tree's depth method triggers a traversal of the entire tree to
    # find maximum depth. Let's do this first.
    it 'finds the depth of single node tree' do
      tree = Tree.new Node.new(9)
      expect(tree.depth).to eq 0
    end

    it 'finds the depth of two node tree with right child' do
      tree = Tree.new Node.new(9)
      tree.add Node.new(14)
      expect(tree.depth).to eq 1
    end

    it 'finds the depth of two node tree with left child' do
      tree = Tree.new Node.new(9)
      tree.add Node.new(4)
      expect(tree.depth).to eq 1
    end

    it 'finds the depth of three node tree' do
      tree = Tree.new Node.new(9)
      tree.add Node.new(14)
      tree.add Node.new(4)
      expect(tree.depth).to eq 1
    end

    it 'finds depth for arbitrary tree' do
      node = Node.new(9)
      tree = Tree.new node
      tree.add Node.new(14)
      tree.add Node.new(4)
      tree.add Node.new(23)
      tree.add Node.new(5)
      tree.add Node.new(99)
      tree.add Node.new(78)
      expect(tree.depth).to eq 4
    end
  end

  describe 'collect node values with in-order traversal' do
    it 'collects node values for single node' do
      node = Node.new(9)
      tree = Tree.new node
      expect(tree.size).to eq 1
      expect(tree.collect).to eq [9]
    end

    it 'collects node values for left node only' do
      node = Node.new(9)
      tree = Tree.new node
      tree.add Node.new(4)
      expect(tree.size).to eq 2
      expect(tree.collect).to eq [4, 9]
    end

    it 'collects node values for right node only' do
      node = Node.new(9)
      tree = Tree.new node
      tree.add Node.new(14)
      expect(tree.size).to eq 2
      expect(tree.collect).to eq [9, 14]
    end

    it 'collects node values' do
      node = Node.new(1)
      tree = Tree.new node
      tree.add Node.new(14)
      tree.add Node.new(4)
      tree.add Node.new(23)
      tree.add Node.new(5)
      tree.add Node.new(99)
      expect(tree.size).to eq 6
      expect(tree.collect).to eq [1, 4, 5, 14, 23, 99]
    end
  end

  describe 'instance methods' do
    before :all do
      node = Node.new(8)
      @tree = Tree.new node
      @tree.add Node.new(14)
      @tree.add Node.new(4)
      @min = Node.new 2
      @tree.add @min
      @tree.add Node.new(5)
      @tree.add Node.new(11)
      @max = Node.new 21
      @tree.add @max

      @expected = [8, 4, 14, 2, 5, 11, 21]
    end

    describe '.to_hash' do
      it 'creates a hash of the tree' do
        node = Node.new(8)
        nodel = Node.new(4)
        noder = Node.new(14)
        tree = Tree.new node
        tree.add nodel
        tree.add noder

        expected = {
          value: node.value,
          uuid: node.uuid,
          left: {
            value: nodel.value,
            uuid: nodel.uuid,
            left: nil,
            right: nil
          },
          right: {
            value: noder.value,
            uuid: noder.uuid,
            left: nil,
            right: nil
          }
        }

        expect(tree.to_hash).to eq expected
      end
    end

    describe '.maximum' do
      it 'finds the node with the largest key' do
        expect(@tree.maximum).to eq @max
      end
    end

    describe '.minimum' do
      it 'finds the node with the smallest key' do
        expect(@tree.minimum).to eq @min
      end
    end

    describe 'breadth first search' do
      it 'performs breadth-first search finds root node' do
        expect(@tree.bfsearch).to eq @expected
      end
    end
  end
end
