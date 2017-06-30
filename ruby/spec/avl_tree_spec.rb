# frozen_string_literal: true

require_relative '../lib/avl_tree'

describe AvlTree do
  describe 'balance_left' do
    let(:root) { AvlNode.new 17 }
    let(:n11) { AvlNode.new 11 }
    let(:n7) { AvlNode.new 7 }
    let(:n2) { AvlNode.new 2 }

    it 'sets root balance to -1 when single left child' do
      tree = described_class.new root
      root.left = n7
      n7.parent = root
      tree.balance_left(n7)
      expect(root.balance_factor).to eq(-1)
    end

    it 'rotates with left chain' do
      tree = described_class.new root
      root.left = n7
      root.left.left = n2
      root.balance_factor = -1
      n2.parent = n7
      n2.parent.parent = root
      tree.balance_left(n7)
      expect(n7.right).to eq root
      expect(root.parent).to eq n7
      expect(n7.left).to eq n2
      expect(tree.root).to eq n7
    end

    it 'rotates with left knee' do
      tree = described_class.new root
      root.left = n7
      root.left.right = n11
      root.balance_factor = -1
      n11.parent = n7
      n11.parent.parent = root
      tree.balance_left(n7)
    end
  end

  describe '#balance_right' do
    let(:root) { AvlNode.new 17 }
    let(:n19) { AvlNode.new 19 }
    let(:n23) { AvlNode.new 23 }

    it 'sets root balance to 1 when single right child' do
      tree = described_class.new root
      root.right = n19
      n19.parent = root
      tree.balance_right(n19)
      expect(root.balance_factor).to eq 1
    end

    it 'rotates with two right children' do
      tree = described_class.new root
      root.right = n19
      root.right.right = n23
      root.balance_factor = 1
      n23.parent = n19
      n23.parent.parent = root
      tree.balance_right(n19)
      expect(tree.root).to eq n19
    end
  end

  describe '#reset_balances' do
  end

  describe '#retrace' do
    let(:root) { AvlNode.new 17 }

    context 'left' do
      it 'finds left child' do
        tree = AvlTree.new root
        expect(tree.root.balance_factor).to eq 0
        tree.insert n7 = AvlNode.new(7)
        expect(tree.root.balance_factor).to eq(-1)
      end

      it 'finds left left child' do
        tree = AvlTree.new root
        expect(tree.root.balance_factor).to eq 0
        tree.insert n7 = AvlNode.new(7)
        expect(tree.root.balance_factor).to eq(-1)
        tree.insert n2 = AvlNode.new(2)

        expect(tree.root).to eq n7
        expect(tree.root.balance_factor).to eq(0)
        expect(root.parent).to eq n7
        expect(n7.right).to eq root
        expect(n7.balance_factor).to eq 0
        expect(root.balance_factor).to eq 0
      end
    end

    context 'right' do
      it 'finds right child' do
        tree = AvlTree.new root
        expect(tree.root.balance_factor).to eq 0
        tree.insert n19 = AvlNode.new(19)
        expect(n19.balance_factor).to eq 0
        expect(tree.root.balance_factor).to eq 1
      end
    end
  end
end
