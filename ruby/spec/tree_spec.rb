# frozen_string_literal: true
require_relative '../lib/tree.rb'
require_relative '../lib/node.rb'

describe Tree do
  describe '#new' do
    it 'instantiates correctly' do
      expect(Tree.new).not_to be_nil
    end

    it 'instantiates a root node' do
      node = Node.new
      expect(tree = Tree.new(node)).not_to be_nil
      expect(tree.root).to eq node
    end
  end

  describe '#size' do
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

  describe '#empty?' do
    it 'returns false when root node is present' do
      root = Node.new 17
      tree = Tree.new root
      expect(tree.empty?).to be false
    end

    it 'returns true when root node is not present' do
      class Tree
        def set_root_to_nil # root is attr_reader
          @root = nil
        end
      end
      tree = Tree.new
      tree.set_root_to_nil
      expect(tree.empty?).to be true
    end
  end

  describe 'tree structure' do
    it 'inserts a node to the tree with existing root' do
      node = Node.new(10)
      tree = Tree.new node
      tree.insert Node.new(2)
      expect(tree.size).to eq 2
      expect(tree.root.left.key).to eq 2

      tree.insert Node.new(33)
      expect(tree.size).to eq 3
      expect(tree.root.right.key).to eq 33

      tree.insert Node.new(23)
      expect(tree.size).to eq 4
      expect(tree.root.right.left.key).to eq 23
    end
  end

  describe 'successor' do
    it 'finds successor to root node' do
      root = Node.new 13
      tree = Tree.new root
      expect(tree.successor(root)).to be root
    end
  end

  describe 'predecessor' do
    it 'finds predecessor to root node' do
      root = Node.new 17
      tree = Tree.new root
      expect(tree.predecessor(root)).to eq root
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
      expect(tree.search(77).object_id).to eq target.object_id
    end
  end

  describe '#height' do
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

  describe '#inorder_iterate' do
    it 'collects node keys for single node' do
      node = Node.new(9)
      tree = Tree.new node
      expect(tree.size).to eq 1
      expect(tree.collect([])).to eq [9]
      expect(tree.list_keys).to eq [9]
      expect(tree.inorder_iterate).to eq [9]
    end

    it 'collects node keys for left node only' do
      node = Node.new(9)
      tree = Tree.new node
      tree.insert Node.new(4)
      expect(tree.size).to eq 2
      expect(tree.collect([])).to eq [4, 9]
      expect(tree.list_keys).to eq [4, 9]
      expect(tree.inorder_iterate).to eq [4, 9]
    end

    it 'collects node keys for degenerate left tree' do
      root = Node.new(17)
      tree = Tree.new root
      tree.insert Node.new(7)
      tree.insert Node.new(3)
      expect(tree.size).to eq 3
      expected = [3, 7, 17]
      expect(tree.collect([])).to eq expected
      expect(tree.list_keys).to eq expected
      expect(tree.inorder_iterate).to eq expected
    end

    it 'collects node keys for right node only' do
      node = Node.new(9)
      tree = Tree.new node
      tree.insert Node.new(14)
      expect(tree.size).to eq 2
      expect(tree.collect([])).to eq [9, 14]
      expect(tree.list_keys).to eq [9, 14]
      expect(tree.inorder_iterate).to eq [9, 14]
    end

    it 'collects node keys for degenerate right tree' do
      root = Node.new(3)
      tree = Tree.new root
      tree.insert Node.new(7)
      tree.insert Node.new(17)
      tree.insert Node.new(77)
      expect(tree.size).to eq 4
      expected = [3, 7, 17, 77]
      expect(tree.collect([])).to eq expected
      expect(tree.list_keys).to eq expected
      expect(tree.inorder_iterate).to eq expected
    end

    it 'collects node keys' do
      node = Node.new(1)
      tree = Tree.new node
      tree.insert Node.new(14)
      tree.insert Node.new(4)
      tree.insert Node.new(23)
      tree.insert Node.new(5)
      tree.insert Node.new(99)
      expect(tree.size).to eq 6
      expect(tree.collect([])).to eq [1, 4, 5, 14, 23, 99]
      expect(tree.list_keys).to eq [1, 4, 5, 14, 23, 99]
      expect(tree.inorder_iterate).to eq [1, 4, 5, 14, 23, 99]
    end

    it 'iterates successfully' do
      root = Node.new(25)
      tree = Tree.new root
      tree.insert Node.new 43
      tree.insert Node.new 8
      tree.insert Node.new 10
      tree.insert Node.new 15
      tree.insert Node.new 33
      tree.insert Node.new 97
      tree.insert Node.new 4
      expect(tree.size).to eq 8
      expected = [4, 8, 10, 15, 25, 33, 43, 97]
      expect(tree.collect([])).to eq expected
      expect(tree.list_keys).to eq expected
      expect(tree.inorder_iterate).to eq expected
    end
  end

  describe '#preorder_iterate' do
    let(:root) { Node.new 17 }
    subject(:tree) { Tree.new root }

    it 'iterates on an empty tree' do
      tree = Tree.new root
      tree.delete 17
      expect(tree.preorder_iterate).to eq []
    end

    it 'iterates on a single node tree' do
      tree = Tree.new root
      expect(tree.preorder_iterate).to eq [17]
    end

    it 'iterates with left child' do
      tree.insert Node.new 7
      expect(tree.preorder_iterate).to eq [17, 7]
    end

    it 'iterates with right child' do
      tree.insert Node.new 29
      expect(tree.preorder_iterate).to eq [17,  29]
    end

    it 'iterates with left and right children' do
      tree.insert Node.new 29
      tree.insert Node.new 7
      expect(tree.preorder_iterate).to eq [17, 7, 29]
    end

    it 'iterates with left full subtree' do
      tree.insert Node.new 7
      tree.insert Node.new 5
      tree.insert Node.new 3
      expect(tree.preorder_iterate).to eq [17, 7, 5, 3]
    end

    it 'iterates with right full subtree' do
      tree.insert Node.new 29
      tree.insert Node.new 43
      tree.insert Node.new 19
      expect(tree.preorder_iterate).to eq [17, 29, 19, 43]
    end

    it 'iterates with degenerate left subtree' do
      tree.insert Node.new 3
      tree.insert Node.new 7
      tree.insert Node.new 11
      tree.insert Node.new 13
      expect(tree.preorder_iterate).to eq [17, 3, 7, 11, 13]
    end

    it 'iterates with degenerate right subtree' do
      tree.insert Node.new 43
      tree.insert Node.new 29
      tree.insert Node.new 23
      tree.insert Node.new 19
      expect(tree.preorder_iterate).to eq [17, 43, 29, 23, 19]
    end

    it 'iterates with larger arbitrary tree' do
      tree.insert Node.new 7
      tree.insert Node.new 5
      tree.insert Node.new 2
      tree.insert Node.new 3
      tree.insert Node.new 29
      tree.insert Node.new 43
      tree.insert Node.new 23
      tree.insert Node.new 19
      expect(tree.preorder_iterate).to eq [17, 7, 5, 2, 3, 29, 23, 19, 43]
    end
  end

  describe '#find_leaf_node' do
    let(:root) { Node.new 17 }
    subject(:tree) { Tree.new root }

    it 'finds self as leaf' do
      expect(tree.find_leaf_node(root)).to eq root
    end

    it 'finds left node as leaf' do
      node7 = Node.new 7
      tree.insert node7
      expect(tree.find_leaf_node(root)).to eq node7
    end

    it 'finds right node as leaf' do
      node29 = Node.new 29
      tree.insert node29
      expect(tree.find_leaf_node(root)).to eq node29
    end

    it 'finds leaf on left elbow' do
      node11 = Node.new 11
      tree.insert Node.new 7
      tree.insert node11
      expect(tree.find_leaf_node(root)).to eq node11
    end

    it 'finds leaf on left subtree' do
      node5 = Node.new 5
      tree.insert Node.new 7
      tree.insert Node.new 11
      tree.insert node5
      expect(tree.find_leaf_node(root)).to eq node5
    end

    it 'finds leaf on right elbow' do
      tree.insert Node.new 29
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_leaf_node(root)).to eq node19
    end

    it 'finds leaf node on right subtree' do
      tree.insert Node.new 29
      tree.insert Node.new 43
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_leaf_node(root)).to eq node19
    end
  end

  describe '#postorder_iterate' do
    let(:root) { Node.new 17 }
    subject(:tree) { Tree.new root }

    it 'deals with empty tree' do
      tree.delete 17
      expect(tree.postorder_iterate).to eq []
    end

    it 'iterates with single root node' do
      expect(tree.postorder_iterate).to eq [17]
    end

    it 'iterates with single left node' do
      tree.insert Node.new 7
      expect(tree.postorder_iterate).to eq [7, 17]
    end

    it 'iterate with a single right node' do
      tree.insert Node.new 29
      expect(tree.postorder_iterate).to eq [29, 17]
    end

    it 'iterate with a 3 node full tree' do
      tree.insert Node.new 29
      tree.insert Node.new 7
      expect(tree.postorder_iterate).to eq [7, 29, 17]
    end

    xit 'iterates on a left elbow' do
      tree.insert Node.new 7
      tree.insert Node.new 11
      expect(tree.postorder_iterate).to eq [11, 7, 17]
    end

    xit 'iterates on a right elbow' do
      tree.insert Node.new 29
      tree.insert Node.new 19
      expect(tree.postorder_iterate).to eq [19, 29, 17]
    end

    xit 'iterate with left full subtree' do
      tree.insert Node.new 7
      tree.insert Node.new 3
      tree.insert Node.new 5
      tree.insert Node.new 2
      expect(tree.postorder_iterate).to eq [2, 5, 3, 7, 17]
    end

    xit 'iterate with augmented left full subtree' do
      tree.insert Node.new 7
      tree.insert Node.new 3
      tree.insert Node.new 5
      tree.insert Node.new 2
      tree.insert Node.new 9
      expect(tree.postorder_iterate).to eq [2, 5, 3, 9, 7, 17]
    end

    xit 'iterate with augmented left full subtree' do
      tree.insert Node.new 7
      tree.insert Node.new 3
      tree.insert Node.new 5
      tree.insert Node.new 2
      tree.insert Node.new 9
      tree.insert Node.new 4
      expect(tree.postorder_iterate).to eq [2, 4, 5, 3, 9, 7, 17]
    end

    xit 'iterate with right full subtree' do
      tree.insert Node.new 29
      tree.insert Node.new 43
      tree.insert Node.new 19
      expect(tree.postorder_iterate).to eq [19, 43, 29, 17]
    end

    xit 'iterate with left degenerate subtree' do
      tree.insert Node.new 3
      tree.insert Node.new 5
      tree.insert Node.new 7
      tree.insert Node.new 11
      expect(tree.postorder_iterate).to eq [11, 7, 5, 3, 17]
    end

    xit 'iterate with right degenerate subtree' do
      tree.insert Node.new 43
      tree.insert Node.new 29
      tree.insert Node.new 23
      tree.insert Node.new 19
      expect(tree.postorder_traverse).to eq [19, 23, 29, 43, 17]
    end

    xit 'iterates with larger arbitrary tree' do
      tree.insert Node.new 7
      tree.insert Node.new 3
      tree.insert Node.new 2
      tree.insert Node.new 5
      tree.insert Node.new 13
      tree.insert Node.new 11

      tree.insert Node.new 29
      tree.insert Node.new 43
      tree.insert Node.new 23
      tree.insert Node.new 19
      expect(tree.postorder_iterate).to eq [2, 5, 3, 11, 13, 7, 19, 23, 43, 29, 17]
    end
  end

  describe '#bst?' do
    let(:root) { Node.new 100 }
    let(:tree) { Tree.new root }

    it 'returns true for binary search tree with 1 node' do
      expect(tree.bst?).to be true
    end
  end

  describe '#full?' do
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
      expect(tree.full?).to be false # nil
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
          'key' => node.key,
          'uuid' => node.uuid,
          'left' => {
            'key' => nodel.key,
            'uuid' => nodel.uuid,
            'left' => nil,
            'right' => nil
          },
          'right' => {
            'key' => noder.key,
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
        expected = '{"key":8,"uuid":"uuid","left":null,"right":null}'
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

      describe 'CLRS 12.1-1 trees of heights 2, 3, 4, 5 and 6' do
        it 'builds tree of height 2' do
          tree = Tree.new Node.new(10)
          tree.insert Node.new(4)
          tree.insert Node.new(17)
          tree.insert Node.new(1)
          tree.insert Node.new(5)
          tree.insert Node.new(16)
          tree.insert Node.new(21)
          expect(tree.height).to eq 2
          expect(tree.bfsearch).to eq [10, 4, 17, 1, 5, 16, 21]
        end

        it 'builds tree of height 3' do
          tree = Tree.new Node.new(5)
          tree.insert Node.new(1)
          tree.insert Node.new(17)
          tree.insert Node.new(4)
          tree.insert Node.new(16)
          tree.insert Node.new(21)
          tree.insert Node.new(10)
          expect(tree.height).to eq 3
          expect(tree.bfsearch).to eq [5, 1, 17, 4, 16, 21, 10]
        end

        it 'builds tree of height 4' do
          tree = Tree.new Node.new(5)
          tree.insert Node.new(1)
          tree.insert Node.new(10)
          tree.insert Node.new(4)
          tree.insert Node.new(16)
          tree.insert Node.new(17)
          tree.insert Node.new(21)
          expect(tree.height).to eq 4
          expect(tree.bfsearch).to eq [5, 1, 10, 4, 16, 17, 21]
        end

        it 'builds tree of height 5' do
          tree = Tree.new Node.new(4)
          tree.insert Node.new(1)
          tree.insert Node.new(5)
          tree.insert Node.new(10)
          tree.insert Node.new(16)
          tree.insert Node.new(17)
          tree.insert Node.new(21)
          expect(tree.height).to eq 5
          expect(tree.bfsearch).to eq [4, 1, 5, 10, 16, 17, 21]
        end

        it 'builds tree of height 6' do
          tree = Tree.new Node.new(1)
          tree.insert Node.new(4)
          tree.insert Node.new(5)
          tree.insert Node.new(10)
          tree.insert Node.new(16)
          tree.insert Node.new(17)
          tree.insert Node.new(21)
          expect(tree.height).to eq 6
          expect(tree.bfsearch).to eq [1, 4, 5, 10, 16, 17, 21]
        end
      end
    end
  end
end
