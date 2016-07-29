require 'busted.runner'()

require 'lib/node'

describe("instantiating nodes", function()
  it("instantiates a node", function()
    table = {
      key = 11,
      left = nil,
      right = nil
    }
    assert.are.same(table, node.new(11))
  end)
end)
