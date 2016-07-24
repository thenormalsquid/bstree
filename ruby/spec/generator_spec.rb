require_relative './spec_helper'
require_relative '../lib/generator'

describe Generator do
  it 'instantiates a binary search tree generator' do
    expect(Generator.new).not_to be nil
  end
end
