# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/avl_node'
require 'shared_examples/insert'

describe AvlNode do
  it_inserts_like 'insertion'

  let(:root) { described_class.new 17 }
  let(:n2) { described_class.new 2 }
  let(:n5) { described_class.new 5 }
  let(:n7) { described_class.new 7 }
  let(:n19) { described_class.new 19 }
  let(:n29) { described_class.new 29 }

  context 'rotate' do
    let(:root) { described_class.new 17 }
    let(:n11) { described_class.new 11 }
    let(:n19) { described_class.new 19 }
    let(:n23) { described_class.new 23 }

    describe '#rotate_left' do # rotate_left
      context 'right chain' do
        it "moves the root node to left child\nrotates counterclockwise with 3 nodes right chain" do
          root.insert n19
          root.insert n23
          root.rotate_left

          expected = [19, 17, 23]
          actual = n19.preorder_collect
          expect(actual).to eq expected
          expect(n19.size).to eq 3

          expect(n19.left).to eq root
          expect(n19.right).to eq n23
          expect(root.parent).to eq n19
          expect(n23.parent).to eq n19
        end
      end

      it 'rotates counterclockwise' do
        root = n11
        root.insert n7
        n17 = described_class.new 17
        n13 = described_class.new 13
        root.insert n17
        root.insert n13
        root.insert n23
        root.rotate_left

        expect(n17.left).to eq root
        expect(root.right).to eq n13
        expect(n17.size).to eq 5
      end

      context 'right knee' do
        it 'does a double' do
          root.insert n29
          root.insert n23
          n29.rotate_right
          first_result = root.preorder_collect
          expect(first_result).to eq [17, 23, 29]
          expect(n23.parent).to eq root
          expect(n29.parent).to eq n23
          expect(root.right.key).to eq n23.key

          root.rotate_left
          expected = [23, 17, 29]
          end_result = n23.preorder_collect
          expect(end_result).to eq expected
          expect(n23.left).to eq root
          expect(n23.right).to eq n29
          expect(n29.parent).to eq n23
          expect(root.parent).to eq n23
        end
      end
    end

    describe '#rotate_right' do # rotate_right
      context 'left chain' do
        it 'moves the root node to right child' do
          root.insert n7
          root.insert n5
          expected = [7, 5, 17]
          root.rotate_right

          actual = n7.preorder_collect
          expect(actual).to eq expected
          expect(n7.size).to eq 3

          expect(n7.left).to eq n5
          expect(n7.right).to eq root
          expect(n5.parent).to eq n7
          expect(root.parent).to eq n7
        end
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

        root.rotate_right
        expect(n11.right).to eq root
        expect(root.left).to eq n13
        expect(n11.size).to eq 5
      end

      context 'left knee' do
        it 'moves the root node to right child' do
          root.insert n7
          root.insert n11
          n7.rotate_left
          expect(n11.left).to eq n7
          expect(root.left).to eq n11

          root.rotate_right
          actual = n11.preorder_collect
          expected = [11, 7, 17]
          expect(actual).to eq expected
          expect(n7.parent).to eq n11
          expect(n11.left).to eq n7
          expect(root.parent).to eq n11
          expect(n11.right).to eq root
        end
      end
    end

    describe '#rotate_left_right' do
      context 'left knee' do
        it 'moves the root node to right child' do
          root.insert n7
          root.insert n11
          root.rotate_left_right

          expected = [11, 7, 17]
          actual = n11.preorder_collect
          expect(actual).to eq expected
          expect(n7.parent).to eq n11
          expect(n11.left).to eq n7
          expect(root.parent).to eq n11
          expect(n11.right).to eq root
        end
      end
    end

    describe '#rotate_right_left' do
      context 'right knee' do
        it 'moves root node to left child' do
          root.insert n29
          root.insert n23
          root.rotate_right_left

          expected = [23, 17, 29]
          actual = n23.preorder_collect
          expect(actual).to eq expected
          expect(n23.left).to eq root
          expect(n23.right).to eq n29
          expect(n29.parent).to eq n23
          expect(root.parent).to eq n23
        end
      end
    end
  end

  # TODO: the test setups here are all valuable, but this is the
  # wrong place to have them, they need to be moved.
  describe '#rebalance' do
    context 'left' do
      context 'chain' do
        example 'insert execution' do
          root.insert n7
          root.insert n5
          root.insert n2
          root.insert described_class.new 1
        end

        xexample 'moves left to root and root to right' do
          root.insert n5
          root.insert n2
          n2.rebalance
          expect(root.parent).to be n5
          expect(n5.right).to be root
          expect(root.left).to be nil
          expect(root.right).to be nil
          expect(n5.parent).to be nil
          expect(n5.left).to be n2
        end
      end

      context 'knee' do
        xit 'executes double rotation left' do
          root.insert n5
          root.insert n2
          # n2.rebalance
          expect(root.parent).to be n5
          expect(n5.right).to be root
          expect(root.left).to be nil
          expect(root.right).to be nil
          expect(n5.parent).to be nil
          expect(n5.left).to be n2
        end
      end
    end

    context 'right' do
      context 'chain' do
        xexample 'moves right to root and root to left' do
          root.insert n19
          root.insert n29
          # n29.rebalance
          expect(root.parent).to be n19
          expect(n19.left).to be root
          expect(root.right).to be nil
          expect(root.left).to be nil
          expect(n19.parent).to be nil
          expect(n19.right).to be n29
        end
      end

      context 'knee' do
        xexample 'executes double rotation right' do
          root.insert n29
          root.insert n19
          # n29.rebalance
          expect(root.parent).to be n19
          expect(n19.left).to be root
          expect(root.right).to be nil
          expect(root.left).to be nil
          expect(n19.parent).to be nil
          expect(n19.right).to be n29
        end
      end
    end
  end

  describe '#balanced?' do
    let(:n11) { described_class.new 11 }
    let(:n43) { described_class.new 43 }

    it 'is true for node with 0 children' do
      expect(root.balanced?).to be true
      expect(root.weight).to eq 0
    end

    it 'is true for a node with only left child' do
      root.insert n7
      expect(root.balanced?).to be true
      expect(root.weight).to eq(-1)
    end

    it 'is true for a node with only right child' do
      root.insert n29
      expect(root.balanced?).to be true
      expect(root.weight).to eq 1
    end

    it 'is true for node with left child and right child' do
      root.insert n7
      root.insert n29
      expect(root.balanced?).to be true
      expect(root.weight).to eq 0
    end

    it 'is false for node with left chain' do
      root.insert n7
      root.insert n2
      expect(root.balanced?).to be false
      expect(root.weight).to eq(-2)
      expect(n7.weight).to eq(-1)
    end

    it 'is false for node with left knee' do
      root.insert n7
      root.insert n11
      expect(root.balanced?).to be false
      expect(root.weight).to eq(-2)
      expect(n7.weight).to eq(1)
      expect(root.left.weight).to eq(1)
    end

    it 'is false for node with right chain' do
      root.insert n29
      root.insert n43
      expect(root.balanced?).to be false
      expect(root.weight).to eq 2
      expect(n29.weight).to eq 1
    end

    it 'is false for node with right knee' do
      root.insert n29
      root.insert n19
      expect(root.balanced?).to be false
      expect(root.weight).to eq 2
      expect(n29.weight).to eq(-1)
      expect(root.right.weight).to eq(-1)
    end

    it 'is true for tree with left bell' do
      root.insert n29
      root.insert n7
      root.insert n11
      root.insert n5
      expect(root.balanced?).to be true
      expect(root.weight).to eq(-1)
    end

    it 'is true for tree with right bell' do
      root.insert n7
      root.insert n29
      root.insert n19
      root.insert n43
      expect(root.balanced?).to be true
      expect(root.weight).to eq(1)
    end

    it 'is true for right and left chain at root' do
      root.insert n7
      root.insert n19
      root.insert n5
      root.insert n29
      root.insert n2
      root.insert n43
      expect(root.balanced?).to be true
      expect(root.weight).to eq(0)
    end
  end

# rubocop: disable Style/BlockComments
=begin
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
      # expect(n2).to receive(:rotate_left).with("correct argument")
      describe 'only right children' do
        xit 'makes a long right list' do
          n2.insert n3
          n2.insert n5
          expect(n2).to receive(:rotate_right) # .with("correct argument")
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
=end Style/BlockComments
  # rubocop:enable
end
