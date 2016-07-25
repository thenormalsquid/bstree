require_relative './spec_helper'
require_relative '../lib/generator'

describe Generator do
  it 'instantiates a binary search tree generator' do
    expect(Generator.new.build([1])).not_to be nil
  end

  it 'builds a one node tree' do
    tree = Generator.new.build([11])
    expect(tree.size).to eq 1
  end

  it 'builds tree1' do
    tree1 = Generator.tree1
    expect(tree1.size).to eq 1
    expect(tree1.bst?).to be true
    expect(tree1.full?).to be true
  end

  it 'builds tree2' do
    tree2 = Generator.tree2
    expect(tree2.size).to eq 2
    expect(tree2.bst?).to be true
    expect(tree2.full?).to be nil
  end
end
