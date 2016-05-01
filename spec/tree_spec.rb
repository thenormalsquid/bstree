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

  describe '.size' do
    it 'adds a node to the tree with existing root' do
      node = Node.new(1)
      tree = Tree.new node
      node2 = Node.new(2)
      tree.add node2
      expect(tree.size).to eq 2

      node3 = Node.new(3)
      tree.add node3
      expect(tree.size).to eq 3
    end
  end

  describe 'tree structure' do
    it 'adds a node to the tree with existing root' do
      node = Node.new(10)
      tree = Tree.new node
      tree.add Node.new(2)
      expect(tree.size).to eq 2
      expect(tree.root.left.value).to eq 2

      tree.add Node.new(33)
      expect(tree.size).to eq 3
      expect(tree.root.right.value).to eq 33

      tree.add Node.new(23)
      expect(tree.size).to eq 4
      expect(tree.root.right.left.value).to eq 23
    end
  end

  describe '.find' do
    xit 'finds a node with given key' do
      node = Node.new(9)
      tree = Tree.new node
      expect(tree.find(9).object_id).to eq node.object_id
    end
  end

  describe 'collect node values with in-order traversal' do
    it 'collects node values for single node' do
      node = Node.new(9)
      tree = Tree.new node
      expect(tree.size).to eq 1
      expect(tree.collect).to eq [9]
    end

    it 'collects node values for left node only' do
      node = Node.new(9)
      tree = Tree.new node
      tree.add Node.new(4)
      expect(tree.size).to eq 2
      expect(tree.collect).to eq [4, 9]
    end

    it 'collects node values for right node only' do
      node = Node.new(9)
      tree = Tree.new node
      tree.add Node.new(14)
      expect(tree.size).to eq 2
      expect(tree.collect).to eq [9, 14]
    end

    it 'collects node values' do
      node = Node.new(1)
      tree = Tree.new node
      tree.add Node.new(14)
      tree.add Node.new(4)
      tree.add Node.new(23)
      tree.add Node.new(5)
      tree.add Node.new(99)
      expect(tree.size).to eq 6
      expect(tree.collect).to eq [1, 4, 5, 14, 23, 99]
    end
  end
end
