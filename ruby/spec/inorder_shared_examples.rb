require 'spec_helper'

require_relative '../lib/node'

RSpec.shared_examples "inorder iterate" do
  describe '#inorder_iterate' do
    let(:root) { Node.new 17 }
    let(:nodes) { [] }
    let(:tree) { described_class.new root }

    subject(:subject) do
      tree.inorder_walk { |node| nodes << node }
      nodes.map(&:key)
    end

    it 'collects node keys for single node' do
      expect(tree.size).to eq 1
      expect(tree.collect([])).to eq [17]
      expect(tree.list_keys).to eq [17]
      expect(subject).to eq [17]
    end

    it 'collects node keys for left node only' do
      tree.insert Node.new(4)
      expect(tree.size).to eq 2
      expect(tree.collect([])).to eq [4, 17]
      expect(tree.list_keys).to eq [4, 17]
      expect(subject).to eq [4, 17]
    end

    it 'collects node keys for degenerate left tree' do
      tree.insert Node.new(7)
      tree.insert Node.new(3)
      expected = [3, 7, 17]
      expect(tree.collect([])).to eq expected
      expect(tree.list_keys).to eq expected
      expect(subject).to eq expected
    end

    it 'collects node keys for right node only' do
      tree.insert Node.new(19)
      expected = [17, 19]
      expect(tree.collect([])).to eq expected
      expect(tree.list_keys).to eq expected
      expect(subject).to eq expected
    end

=begin
    it 'collects node keys for degenerate right tree' do
      root = Node.new(3)
      tree = described_class.new root
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
      tree = described_class.new node
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
      tree = described_class.new root
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
=end
  end
end

