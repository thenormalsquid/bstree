require 'spec_helper'

require_relative '../lib/iterative_node'

RSpec.describe IterativeNode do
  describe '#insert' do
    example 'left node' do
      root = IterativeNode.new 17
      root.insert node7 = IterativeNode.new(7)
      expect(root.left).to eq node7
      root.insert node3 = IterativeNode.new(3)
      expect(root.left.left).to eq node3
      root.insert node11 = IterativeNode.new(11)
      expect(root.left.right).to eq node11
    end

    example 'right node' do
      root = IterativeNode.new 17
      root.insert node23 = IterativeNode.new(23)
      expect(root.right).to eq node23
      root.insert node29 = IterativeNode.new(29)
      expect(root.right.right).to eq node29
      root.insert node19 = IterativeNode.new(19)
      expect(root.right.left).to eq node19
    end
  end
end
