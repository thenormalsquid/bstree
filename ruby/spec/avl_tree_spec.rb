# frozen_string_literal: true

require_relative '../lib/avl_tree'

describe AvlTree do
  describe 'reset_left_balance' do
    let(:root) { AvlNode.new 17 }
    let(:n7) { AvlNode.new 7 }
    let(:n2) { AvlNode.new 2 }

    it 'sets root balance to -1 when single left child' do
      tree = described_class.new root
      root.left = n7
      n7.parent = root
      tree.reset_left_balance(n7, root)
      expect(root.balance_factor).to eq(-1)
    end

    it 'rotates with two left children' do
      tree = described_class.new root
      root.left = n7
      root.left.left = n2
      root.balance_factor = -1
      n2.parent = n7
      n2.parent.parent = root
      tree.reset_left_balance(n7, root)
      expect(n7.right).to eq root
      expect(root.parent).to eq n7
      expect(n7.left).to eq n2
    end
  end

  describe '#reset_right_balance' do
    let(:root) { AvlNode.new 17 }
    let(:n19) { AvlNode.new 19 }
    let(:n23) { AvlNode.new 23 }

    it 'sets root balance to 1 when single right child'
    it 'rotates with two right children'
  end

  describe '#reset_balances' do
  end

  describe '#rebalance' do
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
        # tree.root need to be n7 after the last insert

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
