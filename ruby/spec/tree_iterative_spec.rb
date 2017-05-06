# frozen_string_literal: true
require_relative '../lib/tree.rb'
require_relative '../lib/node.rb'

describe Tree do
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
      tree.insert Node.new 7
      tree.insert Node.new 2
      tree.insert Node.new 11
      tree.insert Node.new 13
      expect(tree.find_leaf_node(root).key).to eq 2
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
      node53 = Node.new 53
      tree.insert node53
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_leaf_node(root)).to eq node19
    end
  end

  # TODO: wrap specs in context blocks as necessary to disambiguate
  # testing situations.
  describe '#find_unvisited_leaf_node' do
    let(:root) { Node.new 17 }
    let(:node7) { Node.new 7 }
    let(:node29) { Node.new 29 }

    subject(:tree) { Tree.new root }

    it 'finds self as leaf' do
      expect(tree.find_unvisited_leaf_node(root)).to eq root
    end

    it 'finds left node as leaf' do
      node7 = Node.new 7
      tree.insert node7
      expect(tree.find_unvisited_leaf_node(root)).to eq node7
    end

    it 'finds right node as leaf' do
      node29 = Node.new 29
      tree.insert node29
      expect(tree.find_unvisited_leaf_node(root)).to eq node29
    end

    it 'finds leaf on left elbow' do
      node11 = Node.new 11
      tree.insert Node.new 7
      tree.insert node11
      expect(tree.find_unvisited_leaf_node(root)).to eq node11
    end

    it 'finds leaf on left subtree' do
      tree.insert Node.new 7
      tree.insert Node.new 2
      tree.insert Node.new 11
      tree.insert Node.new 13
      expect(tree.find_unvisited_leaf_node(root).key).to eq 2
    end

    it 'finds leaf on right elbow' do
      tree.insert Node.new 29
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_unvisited_leaf_node(root)).to eq node19
    end

    it 'finds leaf node on right subtree' do
      tree.insert Node.new 29
      tree.insert Node.new 43
      node53 = Node.new 53
      tree.insert node53
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_unvisited_leaf_node(root)).to eq node19
    end

    context 'full tree with 3 nodes' do
      it 'finds left leaf node on unvisited 3 node full tree' do
        tree.insert node7
        tree.insert node29
        expect(tree.find_unvisited_leaf_node(root)).to eq node7
      end

      it 'finds left leaf node when right child is visited' do
        tree.insert node7
        tree.insert node29.visit
        expect(tree.find_unvisited_leaf_node(root)).to eq node7
      end

      it 'finds right leaf node unvisited when left is visited' do
        node7.visit
        tree.insert node7
        tree.insert node29
        expect(tree.find_unvisited_leaf_node(root)).to eq node29
      end

      it 'finds root when left and right have been visited' do
        tree.insert node29.visit
        tree.insert node7.visit
        expect(tree.find_unvisited_leaf_node(root)).to eq root
      end
    end

    # TODO: probably some of the above specs can be moved here.
    context 'degenerate rght tree on left child' do
      it 'finds the right most leaf after first leftmost is visited'
    end
  end

=begin
  describe '#postorder_iterate' do
    let(:root) { Node.new 17 }
    subject(:tree) { Tree.new root }

    it 'deals with empty tree' do
      tree.delete 17
      expect(tree.postorder_iterate).to eq []
    end

    xit 'iterates with single root node' do
      expect(tree.postorder_iterate).to eq [17]
    end

    xit 'iterates with single left node' do
      tree.insert Node.new 7
      expect(tree.postorder_iterate).to eq [7, 17]
    end

    xit 'iterate with a single right node' do
      tree.insert Node.new 29
      expect(tree.postorder_iterate).to eq [29, 17]
    end

    xit 'iterate with a 4 node full tree' do
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
=end
end
