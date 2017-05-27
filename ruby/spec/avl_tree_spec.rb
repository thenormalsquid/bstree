# frozen_string_literal: true

require_relative '../lib/avl_tree'

describe AvlTree do
  it 'instantiates' do
    expect(AvlTree.new).not_to be nil
  end
end
