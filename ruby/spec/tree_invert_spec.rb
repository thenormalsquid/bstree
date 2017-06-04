# frozen_string_literal: true

require_relative '../lib/tree.rb'

RSpec.describe Tree do
  let(:node_class) { Tree::NODE_CLASS }

  describe '#invert' do
    let(:root) { node_class.new 17 }
    let(:n7) { node_class.new 7 }
    let(:n2) { node_class.new 2 }
    let(:n11) { node_class.new 11 }
    let(:n29) { node_class.new 29 }
    let(:n23) { node_class.new 23 }
    let(:n43) { node_class.new 43 }

    subject(:tree) { described_class.new root }

    xexample 'empty tree' do
      tree.delete root
      expect(tree.invert).to eq [] # bogus, not sure what this will do
    end

    xexample 'single node' do
      expect(tree.invert).to eq [root] # bogus again, not sure how to test this.
    end

    context 'left' do
      xexample 'child' do
        tree.insert n7
        tree.invert
        expect(tree.root.left).to be nil
        expect(tree.root.right).to eq n7
      end

      xexample 'chain' do
        tree.insert n7
        tree.insert n2
        tree.invert
        expect(tree.root.left).to be nil
        expect(tree.root.right).to be n7
        expect(n7.left).to be nil
        expect(n7.right).to be n2
      end

      xexample 'knee' do
        tree.insert n7
        tree.insert n11
        tree.invert
        expect(root.left).to be nil
        expect(root.right).to be n7
        expect(n7.right).to be nil
        expect(n7.left).to be n11
      end
    end

    context 'right' do
      xexample 'child' do
        tree.insert n29
        tree.invert
        expect(root.right).to be nil
        expect(root.left).to be n29
      end

      xexample 'chain' do
        tree.insert n29
        tree.insert n43
        tree.invert
        expect(tree.root.right).to be nil
        expect(tree.root.left).to be n29
        expect(n29.right).to be nil
        expect(n29.left).to be n23
      end

      xexample 'knee' do
        tree.insert n29
        tree.insert n23
        tree.invert
        expect(tree.root.right).to be nil
        expect(tree.root.left).to be n29
        expect(n29.left).to be nil
        expect(n29.right).to be n23
      end
    end

    xexample 'full tree with 3 nodes' do
      tree.insert n7
      tree.insert n29
      tree.invert
      expect(root.right).to be n7
      expect(root.left).to be n29
    end
  end
end
