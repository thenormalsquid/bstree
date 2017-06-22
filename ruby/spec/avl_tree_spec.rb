# frozen_string_literal: true

require_relative '../lib/avl_tree'

describe AvlTree do
  it 'instantiates' do
    expect(AvlTree.new).not_to be nil
  end

  describe '#rebalance' do
    it 'finds left child' do
      tree = AvlTree.new Node.new 17
      tree.insert n7 = Node.new(7)
      expect(tree.rebalance(n7)).to eq 'left'
    end

    it 'finds right child' do
      tree = AvlTree.new Node.new 17
      tree.insert n19 = Node.new(19)
      expect(tree.rebalance(n19)).to eq 'right'
    end
  end
end
