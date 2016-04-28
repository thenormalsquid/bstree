require_relative '../lib/node.rb'

describe Node do
  it 'instantiates' do
    expect(Node.new).not_to be_nil
  end
end
