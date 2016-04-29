require_relative '../lib/tree.rb'
require_relative '../lib/node.rb'

describe Tree do
  it 'instantiates correctly' do
    expect(Tree.new).not_to be_nil
  end

  it 'instantiates a root node' do
    node = Node.new
    expect(tree = Tree.new(node)).not_to be_nil
    expect(tree.root).to eq node
  end

  it 'adds a node to the tree with existing root' do
    node = Node.new(1)
    tree = Tree.new node
    node2 = Node.new(2) 
    tree.add node2
  end
end
