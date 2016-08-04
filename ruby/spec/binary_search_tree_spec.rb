# frozen_string_literal: true
require_relative './spec_helper'

require_relative '../lib/binary_search_tree'

describe BinarySearchTree do
  class Foo
    require 'securerandom'
    include BinarySearchTree
    attr_reader :key, :uuid

    def initialize key
      @key = key
      @uuid = SecureRandom.uuid
    end

    def < other
      @key < other.key
    end

    def >= other
      @key >= other.key
    end

    def > other
      @key > other.key
    end

    def <= other
      @key <= other.key
    end
  end

  before :each do
    @bst = Class.new do
      extend BinarySearchTree
    end
  end

  it 'instatiates included in a class' do
    expect(@bst).to_not be nil
  end

  describe 'algorithm methods' do
    before :all do
      @expected = [2, 3, 4, 5, 8, 10, 20, 27, 33]

      @root = Foo.new(10)
      @foo2 = Foo.new(20)
      @foo3 = Foo.new(5)
      @foo4 = Foo.new(2)
      foo5 = Foo.new(3)
      foo6 = Foo.new(4)
      @foo7 = Foo.new(8)
      foo8 = Foo.new(27)
      @foo9 = Foo.new(33)

      @root.add(@foo2)
      @root.add(@foo3)
      @root.add(@foo4)
      @root.add(foo5)
      @root.add(foo6)
      @root.add(@foo7)
      @root.add(foo8)
      @root.add(@foo9)
    end

    describe '.bst?' do
      it 'determines whether a tree is a binary search tree' do
        expect(@root.bst?).to be true
      end

      it 'identifies single node as binary search tree' do
        node = Foo.new(10)
        expect(node.bst?).to be true
      end

      it 'identifies root and left node as binary search tree' do
        node = Foo.new(10)
        left = Foo.new(5)
        node.add left
        expect(node.bst?).to be true
      end

      it 'identifies root and left node as binary search tree' do
        node = Foo.new(10)
        right = Foo.new(15)
        node.add right
        expect(node.bst?).to be true
      end

      it 'identifies three node as binary search tree' do
        node = Foo.new(10)
        left = Foo.new(5)
        right = Foo.new(15)
        node.add left
        node.add right
        expect(node.bst?).to be true
      end

      it 'identifies three node as not a binary search tree' do
        node = Foo.new(10)
        left = Foo.new(5)
        right = Foo.new(15)
        node.left = right
        node.right = left
        expect(node.bst?).to be false
      end
    end

    describe '.find' do
      it 'finds the root node using the key' do
        expect(@root.find(10)).to eq @root
      end

      it 'finds the root.left node using the key' do
        expect(@root.find(5)).to eq @root.left
      end

      it 'finds the root.right node using the key' do
        expect(@root.find(20)).to eq @root.right
      end

      it 'finds an arbitrary node using the key' do
        expect(@root.find(8)).to eq @foo7
      end
    end

    describe '.present?' do
      it 'finds the root node using the key' do
        expect(@root.present?(10)).to eq true
      end

      it 'finds the root.left node using the key' do
        expect(@root.present?(5)).to eq true
      end

      it 'finds the root.right node using the key' do
        expect(@root.present?(20)).to eq true
      end

      it 'finds an arbitrary node using the key' do
        expect(@root.present?(8)).to eq true
      end

      it 'does not find an arbitrary node when the key is not present' do
        expect(@root.present?(88)).to eq nil
      end
    end

    describe '.add' do
      it 'adds a node' do
        expect(@root.right).to eq @foo2
        expect(@root.left).to eq @foo3
        expect(@root.left.left).to eq @foo4
      end
    end

    describe '.delete' do
      it 'returns the root node when specified for deletion' do
        root = Foo.new(9)
        expect(root.delete(9)).to eq root
        expect(root.bst?).to be true
        expect(root.left.nil?).to be true
        expect(root.right.nil?).to be true
      end

      it 'deletes the right node specified by key' do
        root = Foo.new(9)
        n14 = Foo.new(14)
        root.add n14
        expect(root.delete(14)).to eq n14
        expect(root.bst?).to be true
        expect(n14.left.nil?).to be true
        expect(n14.right.nil?).to be true
      end

      it 'deletes a right node reassiging that nodes child' do
        root = Foo.new(9)
        n14 = Foo.new(14)
        n23 = Foo.new(23)
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
        root = Foo.new(11)
        n17 = Foo.new(17)
        n19 = Foo.new(19)
        n13 = Foo.new(13)
        n5 = Foo.new(5)
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
        root = Foo.new(11)
        n5 = Foo.new(5)
        root.add n5

        n17 = Foo.new(17)
        n13 = Foo.new(13)
        n41 = Foo.new(41)
        n37 = Foo.new(37)
        n31 = Foo.new(31)
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
        expect(root.size).to eq 5
      end

      it 'promotes left node on deletion' do
        root = Foo.new(11)
        n5 = Foo.new(5)
        n7 = Foo.new(7)
        n3 = Foo.new(3)
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
        root = Foo.new(11)
        n5 = Foo.new(5)
        n7 = Foo.new(7)
        n3 = Foo.new(3)
        root.add n5
        root.add n7
        root.add n3

        n17 = Foo.new(17)
        n13 = Foo.new(13)
        n41 = Foo.new(41)
        n37 = Foo.new(37)
        n31 = Foo.new(31)
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

    describe '.collect' do
      it 'collects list of keys in correct order' do
        collector = []
        @root.collect(collector)
        expect(collector).to eq @expected
      end
    end

    describe '.size' do
      it 'finds the size on the fly' do
        expect(@root.size).to eq 9
        expect(@foo4.size).to eq 3
        expect(@foo9.size).to eq 1
      end
    end

    describe '.maximum' do
      it 'finds the node with the largest key' do
        expect(@root.maximum).to eq @foo9
      end
    end

    describe '.minimum' do
      it 'finds the node with the smallest key' do
        expect(@root.minimum).to eq @foo4
      end
    end

    describe '.to_hash' do
      it 'creates a hash of the tree' do
        root = Foo.new 10
        n1 = Foo.new 5
        n2 = Foo.new 15
        root.add n1
        root.add n2

        expected = {
          uuid: root.uuid,
          key: 10,
          left: {
            uuid: n1.uuid,
            key: 5,
            left: nil,
            right: nil
          },
          right: {
            uuid: n2.uuid,
            key: 15,
            left: nil,
            right: nil
          }
        }
        expect(root.to_hash). to eq expected
      end
    end
  end

  describe '.common_parent' do
    let(:root) { Foo.new 11 }
    let(:n5) { Foo.new 5 }
    let(:n3) { Foo.new 3 }
    let(:n7) { Foo.new 7 }
    let(:n13) { Foo.new 13 }
    let(:n17) { Foo.new 17 }
    let(:n19) { Foo.new 19 }

    it 'finds the common parent to itself' do
      expect(root.common_parent(root, root)).to eq root
    end

    it 'finds the common parent for direct left and right children' do
      root.add n5
      root.add n13
      expect(root.common_parent(n5, n13)).to eq root
      expect(root.common_parent(n13, n5)).to eq root
    end

    it 'finds common parent for children on left side of root' do
      root.add n5
      root.add n7
      root.add n3
      expect(root.common_parent(n3, n7)).to eq n5
      expect(root.common_parent(n7, n3)).to eq n5
    end

    it 'finds common parent for nodes in series' do
      root.add n5
      root.add n3
      expect(root.common_parent(n3, n5)).to eq n5
      expect(root.common_parent(n5, n3)).to eq n5
    end

    it 'finds common parent for children right of root' do
      root.add n17
      root.add n13
      root.add n19
      expect(root.common_parent(n13, n19)).to eq n17
      expect(root.common_parent(n19, n13)).to eq n17
    end

    it 'finds children either side of root' do
      root.add n5
      root.add n7
      root.add n3
      root.add n17
      root.add n13
      root.add n19
      expect(root.common_parent(n3, n19)).to eq root
      expect(root.common_parent(n19, n3)).to eq root
    end
  end

  describe 'height of tree' do
    it 'finds the height of single node tree' do
      node = Foo.new(9)
      expect(node.height).to eq 0
    end

    it 'finds the height of two node tree with right child' do
      node = Foo.new(9)
      node.add Foo.new(14)
      expect(node.height).to eq 1
    end

    it 'finds the height of two node tree with left child' do
      node = Foo.new(9)
      node.add Foo.new(4)
      expect(node.height).to eq 1
    end

    it 'finds the height of three node tree' do
      node = Foo.new(9)
      node.add Foo.new(14)
      node.add Foo.new(4)
      expect(node.height).to eq 1
    end

    it 'finds height for arbitrary tree' do
      node = Foo.new(9)
      node.add Foo.new(14)
      node.add Foo.new(4)
      node.add Foo.new(23)
      node.add Foo.new(5)
      node.add Foo.new(99)
      node.add Foo.new(78)
      expect(node.height).to eq 4
    end
  end

  describe 'method overriding' do
    class Bar
      require 'securerandom'
      include BinarySearchTree
      attr_reader :key, :uuid

      def initialize key
        @key = key
        @uuid = SecureRandom.uuid
      end
    end

    it 'fails if comparison operator is not overriden' do
      bar = Bar.new 9
      expect { bar.add(Bar.new(5)) }.to raise_error(NoMethodError)
    end
  end
end
