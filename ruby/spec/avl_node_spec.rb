# frozen_string_literal: true
require_relative '../lib/avl_node'

describe AvlNode do
  describe '.insert' do
    let(:root) { AvlNode.new 11 }
    let(:n3) { AvlNode.new 3 }
    let(:n5) { AvlNode.new(5) }
    let(:n7) { AvlNode.new 7 }
    let(:n11) { AvlNode.new 11 }
    let(:n13) { AvlNode.new 13 }
    let(:n17) { AvlNode.new 17 }
    let(:n19) { AvlNode.new 19 }

    it 'inserts a node and balances' do
      n11.add n5
      expect(n5.balanced?).to be true
      expect(n5.weight).to be 0
    end
  end

  describe 'rotations' do
    it 'rotates counterclockwise' do
      root = AvlNode.new 17
      n23 = AvlNode.new 23
      root.add n23

      n11 = AvlNode.new 11
      n13 = AvlNode.new 13
      n7 = AvlNode.new 7
      root.add n11
      root.add n13
      root.add n7

      root.rotate_ccw
      expect(n11.right).to eq root
      expect(root.left).to eq n13
      expect(n11.size).to eq 5
    end

    it 'rotates clockwise' do
      root = AvlNode.new 11
      n7 = AvlNode.new 7
      root.add n7
      n17 = AvlNode.new 17
      n13 = AvlNode.new 13
      n23 = AvlNode.new 23
      root.add n17
      root.add n13
      root.add n23

      root.rotate_cw
      expect(n17.left).to eq root
      expect(root.right).to eq n13
      expect(n17.size).to eq 5
    end
  end
end
