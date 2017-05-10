require 'spec_helper'

require_relative '../lib/iterative_node'

RSpec.describe IterativeNode do
  describe '#insert' do
    example 'left node' do
      root = IterativeNode.new 2
      root.insert left_node = IterativeNode.new(1)
      expect(root.left).to eq left_node
    end

    example 'right node' do
      root = IterativeNode.new 1
      root.insert right_node = IterativeNode.new(2)
      expect(root.right).to eq right_node
    end
  end
end
