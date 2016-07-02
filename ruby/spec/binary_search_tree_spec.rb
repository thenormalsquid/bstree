# frozen_string_literal: true
require_relative './spec_helper'

require_relative '../lib/binary_search_tree'

describe BinarySearchTree do
  class Foo
    require 'securerandom'
    include BinarySearchTree
    attr_reader :key, :uuid

    def initialize key
      @key = key
      @uuid = SecureRandom.uuid
    end

    def < other
      @key < other.key
    end
  end

  before :each do
    @bst = Class.new do
      extend BinarySearchTree
    end
  end

  it 'instatiates included in a class' do
    expect(@bst).to_not be nil
  end

  describe 'algorithm methods' do
    before :all do
      @expected = [2, 3, 4, 5, 8, 10, 20, 27, 33]

      @root = Foo.new(10)
      @foo2 = Foo.new(20)
      @foo3 = Foo.new(5)
      @foo4 = Foo.new(2)
      foo5 = Foo.new(3)
      foo6 = Foo.new(4)
      @foo7 = Foo.new(8)
      foo8 = Foo.new(27)
      @foo9 = Foo.new(33)

      @root.add(@foo2)
      @root.add(@foo3)
      @root.add(@foo4)
      @root.add(foo5)
      @root.add(foo6)
      @root.add(@foo7)
      @root.add(foo8)
      @root.add(@foo9)
    end

    describe '.find' do
      it 'finds the root node using the key' do
        expect(@root.find(10)).to eq @root
      end

      it 'finds the root.left node using the key' do
        expect(@root.find(5)).to eq @root.left
      end

      it 'finds the root.right node using the key' do
        expect(@root.find(20)).to eq @root.right
      end

      it 'finds an arbitrary node using the key' do
        expect(@root.find(8)).to eq @foo7
      end
    end

    describe '.present?' do
      it 'finds the root node using the key' do
        expect(@root.present?(10)).to eq true
      end

      it 'finds the root.left node using the key' do
        expect(@root.present?(5)).to eq true
      end

      it 'finds the root.right node using the key' do
        expect(@root.present?(20)).to eq true
      end

      it 'finds an arbitrary node using the key' do
        expect(@root.present?(8)).to eq true
      end

      it 'does not find an arbitrary node when the key is not present' do
        expect(@root.present?(88)).to eq nil
      end
    end

    describe '.add' do
      it 'adds a node' do
        expect(@root.right).to eq @foo2
        expect(@root.left).to eq @foo3
        expect(@root.left.left).to eq @foo4
      end
    end

    describe '.collect' do
      it 'collects list of keys in correct order' do
        collector = []
        @root.collect(collector)
        expect(collector).to eq @expected
      end
    end

    describe '.maximum' do
      it 'finds the node with the largest key' do
        expect(@root.maximum).to eq @foo9
      end
    end

    describe '.minimum' do
      it 'finds the node with the smallest key' do
        expect(@root.minimum).to eq @foo4
      end
    end

    describe '.to_hash' do
      it 'creates a hash of the tree' do
        root = Foo.new 10
        n1 = Foo.new 5
        n2 = Foo.new 15
        root.add n1
        root.add n2

        expected = {
          uuid: root.uuid,
          left: {
            uuid: n1.uuid,
            left: nil,
            right: nil
          },
          right: {
            uuid: n2.uuid,
            left: nil,
            right: nil
          }
        }
        expect(root.to_hash). to eq expected
      end
    end
  end
end
