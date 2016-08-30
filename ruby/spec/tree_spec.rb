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
    it 'inserts a node to the tree with existing root' do
      node = Node.new(1)
      tree = Tree.new node
      node2 = Node.new(2)
      tree.insert node2
      expect(tree.size).to eq 2

      node3 = Node.new(3)
      tree.insert node3
      expect(tree.size).to eq 3
    end
  end

  describe 'tree structure' do
    it 'inserts a node to the tree with existing root' do
      node = Node.new(10)
      tree = Tree.new node
      tree.insert Node.new(2)
      expect(tree.size).to eq 2
      expect(tree.root.left.value).to eq 2

      tree.insert Node.new(33)
      expect(tree.size).to eq 3
      expect(tree.root.right.value).to eq 33

      tree.insert Node.new(23)
      expect(tree.size).to eq 4
      expect(tree.root.right.left.value).to eq 23
    end
  end

  describe '.delete' do
    it 'returns the root node when specified for deletion' do
      root = Node.new(9)
      tree = Tree.new root
      expect(tree.delete(9)).to eq root
      expect(tree.root.nil?).to be true
      expect(tree.size).to eq 0
    end

    it 'deletes the right node specified by key' do
      root = Node.new(9)
      tree = Tree.new root
      n14 = Node.new(14)
      tree.insert n14
      expect(tree.delete(14)).to eq n14
      expect(tree.bst?).to be true
      expect(n14.left.nil?).to be true
      expect(n14.right.nil?).to be true
      expect(tree.size).to eq 1
    end

    it 'deletes a right node reassiging that nodes child' do
      root = Node.new(9)
      tree = Tree.new root
      n14 = Node.new(14)
      n23 = Node.new(23)
      tree.insert n14
      tree.insert n23

      expect(tree.delete(14)).to eq n14
      expect(n14.left.nil?).to be true
      expect(n14.right.nil?).to be true
      expect(tree.bst?).to be true
      expect(tree.root.right).to eq n23
      expect(tree.size).to eq 2
    end

    it 'reassigns right subtree on deletion' do
      root = Node.new(11)
      tree = Tree.new root
      n17 = Node.new(17)
      n19 = Node.new(19)
      n13 = Node.new(13)
      n5 = Node.new(5)
      tree.insert n17
      tree.insert n19
      tree.insert n13
      tree.insert n5

      expect(tree.delete(17)).to eq n17
      expect(tree.bst?).to be true
      expect(n17.left.nil?).to be true
      expect(n17.right.nil?).to be true
      expect(tree.root.right).to eq n19
      expect(tree.root.right.left).to eq n13
      expect(tree.size).to eq 4
    end

    it 'rebuilds subtree after deleting node' do
      root = Node.new(11)
      tree = Tree.new root
      n5 = Node.new(5)
      tree.insert n5

      n17 = Node.new(17)
      n13 = Node.new(13)
      n41 = Node.new(41)
      n37 = Node.new(37)
      n31 = Node.new(31)
      tree.insert n17
      tree.insert n13
      tree.insert n41
      tree.insert n37
      tree.insert n31
      expect(tree.delete(17)).to eq n17
      expect(tree.bst?).to be true
      expect(n17.left.nil?).to be true
      expect(n17.right.nil?).to be true
      expect(tree.root.right).to eq n41
      expect(n31.left).to eq n13
      expect(tree.size).to eq 6
      # delete a leaf node
      expect(tree.delete(13)).to eq n13
      expect(n31.left).to be nil
      expect(tree.size).to eq 5
    end

    it 'promotes left node on deletion' do
      root = Node.new(11)
      tree = Tree.new root
      n5 = Node.new(5)
      n7 = Node.new(7)
      n3 = Node.new(3)
      tree.insert n5
      tree.insert n7
      tree.insert n3

      expect(tree.delete(5)).to eq n5
      expect(tree.bst?).to be true
      expect(n5.left.nil?).to be true
      expect(n5.right.nil?).to be true
      expect(tree.root.left).to eq n3
      expect(n3.right).to eq n7
      expect(tree.size).to eq 3
    end

    it 'deletes the root node correctly' do
      root = Node.new(11)
      tree = Tree.new root
      n5 = Node.new(5)
      n7 = Node.new(7)
      n3 = Node.new(3)
      tree.insert n5
      tree.insert n7
      tree.insert n3

      n17 = Node.new(17)
      n13 = Node.new(13)
      n41 = Node.new(41)
      n37 = Node.new(37)
      n31 = Node.new(31)
      tree.insert n17
      tree.insert n13
      tree.insert n41
      tree.insert n37
      tree.insert n31

      expect(tree.delete(11)).to eq root
      expect(tree.root).to eq n5
      expect(root.left.nil?).to be true
      expect(root.right.nil?).to be true

      expect(n5.bst?).to be true
      expect(n5.left).to eq n3
      expect(n5.right).to eq n7
      expect(n7.right).to eq n17
      expect(tree.size).to eq 8
    end
  end

  describe 'successor' do
    it 'finds successor to root node' do
      root = Node.new(13)
      tree = Tree.new(root)
      expect(tree.successor(root)).to be root
    end
  end

  describe '.find' do
    it 'finds a node with given key' do
      node = Node.new(9)
      tree = Tree.new node
      tree.insert Node.new(14)
      tree.insert Node.new(4)
      tree.insert Node.new(23)
      tree.insert Node.new(5)
      tree.insert Node.new(99)
      target = Node.new(77)
      tree.insert target
      expect(tree.size).to eq 7
      expect(tree.find(77).object_id).to eq target.object_id
    end
  end

  describe 'height of tree' do
    # Depth should be incremented when nodes are inserted,
    # if the height is to be considered as an attribute of the tree.
    # As a virtual attribute (to borrow a notion from Ruby), calling a
    # tree's height method triggers a traversal of the entire tree to
    # find maximum height. Let's do this first.
    it 'finds the height of single node tree' do
      tree = Tree.new Node.new(9)
      expect(tree.height).to eq 0
    end

    it 'finds the height of two node tree with right child' do
      tree = Tree.new Node.new(9)
      tree.insert Node.new(14)
      expect(tree.height).to eq 1
    end

    it 'finds the height of two node tree with left child' do
      tree = Tree.new Node.new(9)
      tree.insert Node.new(4)
      expect(tree.height).to eq 1
    end

    it 'finds the height of three node tree' do
      tree = Tree.new Node.new(9)
      tree.insert Node.new(14)
      tree.insert Node.new(4)
      expect(tree.height).to eq 1
    end

    it 'finds height for arbitrary tree' do
      node = Node.new(9)
      tree = Tree.new node
      tree.insert Node.new(14)
      tree.insert Node.new(4)
      tree.insert Node.new(23)
      tree.insert Node.new(5)
      tree.insert Node.new(99)
      tree.insert Node.new(78)
      expect(tree.height).to eq 4
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
      tree.insert Node.new(4)
      expect(tree.size).to eq 2
      expect(tree.collect).to eq [4, 9]
    end

    it 'collects node values for right node only' do
      node = Node.new(9)
      tree = Tree.new node
      tree.insert Node.new(14)
      expect(tree.size).to eq 2
      expect(tree.collect).to eq [9, 14]
    end

    it 'collects node values' do
      node = Node.new(1)
      tree = Tree.new node
      tree.insert Node.new(14)
      tree.insert Node.new(4)
      tree.insert Node.new(23)
      tree.insert Node.new(5)
      tree.insert Node.new(99)
      expect(tree.size).to eq 6
      expect(tree.collect).to eq [1, 4, 5, 14, 23, 99]
    end
  end

  describe '.bst?' do
    let(:root) { Node.new 100 }
    let(:tree) { Tree.new root }

    it 'returns true for binary search tree with 1 node' do
      expect(tree.bst?).to be true
    end
  end

  describe '.full?' do
    let(:root) { Node.new 100 }
    let(:tree) { Tree.new root }
    let(:left) { Node.new 50 }
    let(:right) { Node.new 150 }
    let(:l2) { Node.new 25 }
    let(:l3) { Node.new 75 }
    let(:l4) { Node.new 15 }

    it 'returns true for node with 0 children' do
      expect(root.full?).to be true
    end

    it 'returns true for node with 2 children' do
      tree.insert left
      tree.insert right
      expect(tree.full?).to be true
    end

    it 'returns false for a node with only one child' do
      tree.insert left
      expect(tree.full?).to be nil
    end

    it 'returns true for tree with 5 nodes' do
      tree.insert left
      tree.insert right
      tree.insert l2
      tree.insert l3
      expect(tree.full?).to be true
    end

    it 'returns nil for tree with 6 nodes' do
      tree.insert left
      tree.insert right
      tree.insert l2
      tree.insert l3
      tree.insert Node.new 145
      expect(tree.full?).to be_falsy
    end

    it 'returns nil for tree with 6 nodes' do
      tree.insert left
      tree.insert right
      tree.insert l2
      tree.insert l3
      tree.insert l4
      tree.insert Node.new 145
      expect(tree.full?).to be_falsy
    end
  end

  describe 'instance methods' do
    before :all do
      node = Node.new(8, 'uuid8')
      @tree = Tree.new node
      @tree.insert Node.new(14, 'uuid14')
      @tree.insert Node.new(4, 'uuid4')
      @min = Node.new 2, 'uuid2'
      @tree.insert @min
      @tree.insert Node.new(5, 'uuid5')
      @tree.insert Node.new(11, 'uuid11')
      @max = Node.new 21, 'uuid21'
      @tree.insert @max

      @expected = [8, 4, 14, 2, 5, 11, 21]
    end

    describe '.to_hash' do
      it 'creates a hash of the tree' do
        node = Node.new(8)
        nodel = Node.new(4)
        noder = Node.new(14)
        tree = Tree.new node
        tree.insert nodel
        tree.insert noder

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

        expect(tree.to_hash).to eq expected
      end
    end

    describe '.to_json' do
      it 'creates json representation of tree' do
        root = Node.new(8)
        allow(root).to receive(:uuid).and_return('uuid')
        tree = Tree.new root
        expected = '{"value":8,"uuid":"uuid","left":null,"right":null}'
        expect(tree.to_json).to eq expected
      end
    end

    describe '.to_json_file' do
      it 'writes json to a file' do
        require 'open3'
        filename = 'tree_with_nodes.json'
        @tree.to_json_file "/tmp/#{filename}"
        diff = "diff /tmp/#{filename} spec/output/json/#{filename}"
        output, _status = Open3.capture2e(diff)
        expect(output.empty?).to be true
      end
    end

    describe '.from_json_file' do
      it 'reads from json file' do
        root = Node.new(8)
        tree = Tree.new root
        tree.to_json_file '/tmp/tree.json'

        saved_tree = Tree.from_json_file '/tmp/tree.json'
        expect(saved_tree.root.uuid).to eq tree.root.uuid
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
