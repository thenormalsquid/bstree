require_relative '../lib/node.rb'

require 'pry'

describe Node do
  it 'instantiates' do
    expect(Node.new).not_to be_nil
  end

  it 'adds left node' do
    node = Node.new 2
    left_node = Node.new 1
    node.add left_node
    expect(node.left).to eq left_node
  end

  it 'adds right node' do
    node = Node.new 1
    right_node = Node.new 2
    node.add right_node
    expect(node.right).to eq right_node
  end

  it 'adds node value' do
    value = 1
    node = Node.new(value)
    expect(node.value).to eq value
  end

  it 'compares values with <=>' do
    node1 = Node.new(1)
    node2 = Node.new(2)
    expect(node1 <=> node2).to be 1
  end

  it 'compares values with <' do
    node1 = Node.new(1)
    node2 = Node.new(2)
    expect(node1 < node2).to be true
  end
end
