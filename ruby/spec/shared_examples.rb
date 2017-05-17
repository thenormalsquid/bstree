# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples 'insertion' do
  let(:root) { described_class.new 17 }

  describe '#insert' do
    example 'left node' do
      root.insert node7 = described_class.new(7)
      expect(root.left).to eq node7
      root.insert node3 = described_class.new(3)
      expect(root.left.left).to eq node3
      root.insert node11 = described_class.new(11)
      expect(root.left.right).to eq node11
    end

    example 'right node' do
      root.insert node23 = described_class.new(23)
      expect(root.right).to eq node23
      root.insert node29 = described_class.new(29)
      expect(root.right.right).to eq node29
      root.insert node19 = described_class.new(19)
      expect(root.right.left).to eq node19
    end
  end
end

RSpec.shared_examples 'extreme elements' do
  let(:root) { described_class.new 17 }

  before do
    root.insert @node2 = described_class.new(2)
    root.insert @node29 = described_class.new(29)
  end

  describe '#minimum' do
    it 'finds the minimum node' do
      expect(root.minimum).to eq @node2
    end
  end

  describe '#maximum' do
    it 'finds the minimum node' do
      expect(root.maximum).to eq @node29
    end
  end
end
