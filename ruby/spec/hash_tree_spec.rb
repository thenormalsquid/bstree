# frozen_string_literal: true
require_relative '../lib/hash_tree.rb'

describe HashTree do
  it 'instantiates' do
    expect(HashTree.new).not_to be nil
  end
end
