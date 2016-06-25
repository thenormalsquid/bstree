require_relative './spec_helper'

require_relative '../lib/binary_search_tree'

describe BinarySearchTree do
  before :each do
    @bst = Class.new do
      extend BinarySearchTree
    end
  end

  it 'instatiates included in a class' do
    expect(@bst).to_not be nil
  end

  it 'adds a node' do
    class Foo
      include BinarySearchTree
      attr_reader :key

      def initialize(key)
        @key = key
      end

      def <(other)
        @key < other.key
      end
    end

    foo1 = Foo.new(1)
    foo2 = Foo.new(2)
    foo1.add(foo2)

    expect(foo1.right).to eq foo2
  end

end
