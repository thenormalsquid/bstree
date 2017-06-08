# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/avl_node'

describe AvlNode do
  let(:root) { described_class.new 17 }
  let(:node2) { described_class.new 2 }
  let(:node5) { described_class.new 5 }

  describe '#rebalance' do
    context 'left' do
      context 'chain' do
        xexample 'moves root->left to root and root to left->right' do
          root.insert node5
          root.insert node2
          node2.rebalance
          expect(root.parent).to be node5
          expect(node.right).to be root
          expect(root.left).to be nil
          expect(root.right).to be nil
          expect(node5.parent).to be nil
          expect(node5.left).to be node2
        end
      end

      context 'knee' do
        it 'executes double rotation left'
      end
    end

    context 'right' do
      context 'chain' do
        example 'moves root->right to root and root to right->left'
      end

      context 'knee' do
        it 'executes double rotation right'
      end
    end
  end

  describe '#balanced?' do
    let(:node7) { described_class.new 7 }
    let(:node11) { described_class.new 11 }
    let(:node19) { described_class.new 19 }
    let(:node29) { described_class.new 29 }
    let(:node43) { described_class.new 43 }

    it 'is true for node with 0 children' do
      expect(root.balanced?).to be true
      expect(root.weight).to eq 0
    end

    it 'is true for a node with only left child' do
      root.insert node7
      expect(root.balanced?).to be true
      expect(root.weight).to eq(-1)
    end

    it 'is true for a node with only right child' do
      root.insert node29
      expect(root.balanced?).to be true
      expect(root.weight).to eq 1
    end

    it 'is true for node with left child and right child' do
      root.insert node7
      root.insert node29
      expect(root.balanced?).to be true
      expect(root.weight).to eq 0
    end

    it 'is false for node with left chain' do
      root.insert node7
      root.insert node2
      expect(root.balanced?).to be false
      expect(root.weight).to eq(-2)
      expect(node7.weight).to eq(-1)
    end

    it 'is false for node with left knee' do
      root.insert node7
      root.insert node11
      expect(root.balanced?).to be false
      expect(root.weight).to eq(-2)
      expect(node7.weight).to eq(1)
      expect(root.left.weight).to eq(1)
    end

    it 'is false for node with right chain' do
      root.insert node29
      root.insert node43
      expect(root.balanced?).to be false
      expect(root.weight).to eq 2
      expect(node29.weight).to eq 1
    end

    it 'is false for node with right knee' do
      root.insert node29
      root.insert node19
      expect(root.balanced?).to be false
      expect(root.weight).to eq 2
      expect(node29.weight).to eq(-1)
      expect(root.right.weight).to eq(-1)
    end

    it 'is true for tree with left bell' do
      root.insert node29
      root.insert node7
      root.insert node11
      root.insert node5
      expect(root.balanced?).to be true
      expect(root.weight).to eq(-1)
    end

    it 'is true for tree with right bell' do
      root.insert node7
      root.insert node29
      root.insert node19
      root.insert node43
      expect(root.balanced?).to be true
      expect(root.weight).to eq(1)
    end

    it 'is true for right and left chain at root' do
      root.insert node7
      root.insert node19
      root.insert node5
      root.insert node29
      root.insert node2
      root.insert node43
      expect(root.balanced?).to be true
      expect(root.weight).to eq(0)
    end
  end

  context 'rotate' do
    let(:root) { described_class.new 17 }
    let(:n7) { described_class.new 7 }
    let(:n5) { described_class.new 5 }
    let(:n19) { described_class.new 19 }
    let(:n23) { described_class.new 23 }

    describe '#simple_left' do
      context 'right chain' do
        it 'moves the root node to left child' do
          root.insert n19
          root.insert n23
          root.simple_left
          expected = [19, 17, 23]
          actual = n19.preorder_collect
          expect(actual).to eq expected
        end
      end

      context 'right knee' do
      end
    end

    describe '#simple_right' do
      context 'left chain' do
        it 'moves the root node to right child' do
          root.insert n7
          root.insert n5
          expected = [7, 5, 17]
          root.simple_right
          actual = n7.preorder_collect
          expect(actual).to eq expected
        end
      end

      context 'left knee' do
      end
    end
  end


  # TODO: figure out what the actual methods are, then
  # work out the method names here for the describe blocks.
  describe 'rotations' do
    it 'rotates counterclockwise with 3 nodes right chain' do
      root = described_class.new 17
      n23 = described_class.new 23
      n29 = described_class.new 29
      root.insert n23
      root.insert n29

      root.rotate_ccw
      expect(n23.left).to eq root
      expect(n23.right).to eq n29
      expect(n23.size).to eq 3
    end

    it 'rotates clockwise with 3 nodes left chain' do
      root = described_class.new 11
      n5 = described_class.new 5
      n3 = described_class.new 3
      root.insert n5
      root.insert n3
      root.rotate_cw
      expect(n5.right).to eq root
      expect(n5.left).to eq n3
      expect(n5.size).to eq 3
    end

    it 'rotates clockwise' do
      root = described_class.new 17
      n23 = described_class.new 23
      root.insert n23

      n11 = described_class.new 11
      n13 = described_class.new 13
      n7 = described_class.new 7
      root.insert n11
      root.insert n13
      root.insert n7

      root.rotate_cw
      expect(n11.right).to eq root
      expect(root.left).to eq n13
      expect(n11.size).to eq 5
    end

    it 'rotates counterclockwise' do
      root = described_class.new 11
      n7 = described_class.new 7
      root.insert n7
      n17 = described_class.new 17
      n13 = described_class.new 13
      n23 = described_class.new 23
      root.insert n17
      root.insert n13
      root.insert n23

      root.rotate_ccw
      expect(n17.left).to eq root
      expect(root.right).to eq n13
      expect(n17.size).to eq 5
    end
  end

  describe '.insert' do
    let(:root) { described_class.new 11 }
    let(:n3) { described_class.new 3 }
    let(:n5) { described_class.new(5) }
    let(:n7) { described_class.new 7 }
    let(:n11) { described_class.new 11 }
    let(:n13) { described_class.new 13 }
    let(:n17) { described_class.new 17 }
    let(:n19) { described_class.new 19 }

    it 'returns current root on insertion'

    it 'inserts a node and balances' do
      n11.insert n5
      expect(n5.balanced?).to be true
      expect(n5.weight).to be 0
    end
  end

  describe 'build avl trees from sorted lists' do
    describe 'trees as linked lists' do
      let(:n2) { described_class.new 2 }
      let(:n3) { described_class.new 3 }
      let(:n5) { described_class.new 5 }
      let(:n7) { described_class.new 7 }
      let(:n11) { described_class.new 11 }
      let(:n13) { described_class.new 13 }
      let(:n17) { described_class.new 17 }
      let(:n19) { described_class.new 19 }
      let(:n23) { described_class.new 23 }
      let(:n29) { described_class.new 29 }

      # Check to ensure the rotations are getting called
      # correctly.
      #
      # Consider having insert return the current root.
      #
      # expect(n2).to receive(:rotate_ccw).with("correct argument")
      describe 'only right children' do
        xit 'makes a long right list' do
          n2.insert n3
          n2.insert n5
          expect(n2).to receive(:rotate_cw) # .with("correct argument")
          # expect(n2.height).to eq 1
          # expect(n3.height).to eq 0
          # expect(n3.height).to eq 0
          # expect(n2.pathological?).to be false

          # n2.insert n11
          # n2.insert n13
          # n2.insert n17
          # n2.insert n19
          # n2.insert n23
          # n2.insert n29
          # expect(n2.height).to eq 9
          # expect(n29.height).to eq 0
          # expect(n2.pathological?).to be true
          # expect(n29.pathological?).to be false
          # expect(n23.pathological?).to be false
          # expect(n19.pathological?).to be true
          # expect(n2.degenerate?).to be true
        end
      end

      describe 'only left children' do
        xit 'makes a long left list' do
          n29.insert n23
          n29.insert n19
          n29.insert n17
          n29.insert n13
          n29.insert n11
          n29.insert n7
          n29.insert n5
          n29.insert n3
          n29.insert n2
          expect(n29.height).to eq 9
          expect(n2.height).to eq 0
          # expect(n29.pathological?).to be true
          # expect(n5.pathological?).to be true
          # expect(n3.pathological?).to be false
          # expect(n29.degenerate?).to be true
        end
      end

      describe 'left and right children, alternately aperiodically' do
      end
    end
  end
end
