# frozen_string_literal: true

require_relative '../lib/avl_tree'

describe AvlTree do
  let(:n1) { AvlNode.new 1 }
  let(:n2) { AvlNode.new 2 }
  let(:n3) { AvlNode.new 3 }
  let(:n4) { AvlNode.new 4 }
  let(:n5) { AvlNode.new 5 }
  let(:n6) { AvlNode.new 6 }
  let(:n7) { AvlNode.new 7 }
  let(:n8) { AvlNode.new 8 }
  let(:n9) { AvlNode.new 9 }
  let(:n10) { AvlNode.new 10 }
  let(:n11) { AvlNode.new 11 }
  let(:n12) { AvlNode.new 12 }
  let(:n13) { AvlNode.new 13 }
  let(:n14) { AvlNode.new 14 }
  let(:n15) { AvlNode.new 15 }

  context 'counting up' do
    it 'results in a perfect tree' do
      tree = AvlTree.new n1

      tree.insert n2
      expect(tree.root.balance_factor).to eq 1

      tree.insert n3
      expect(tree.root.balance_factor).to eq 0
      expect(tree.root).to eq n2
      expect(tree.root.left).to eq n1
      expect(tree.root.right).to eq n3

      tree.insert n4
      expect(tree.root.balance_factor).to eq 1
      expect(tree.root.left).to eq n1
      expect(tree.root.right).to eq n3
      expect(n3.balance_factor).to eq 1
      expect(n3.right).to eq n4

      tree.insert n5
      # expect(tree.root.balance_factor).to eq 0
      expect(tree.root.key).to eq n2.key
      # expect(tree.root.left).to eq n1
    end
  end
end
