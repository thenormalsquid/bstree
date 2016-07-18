require 'busted.runner'()

require 'lib/tree'

describe("instantiating trees", function()
  it("instantiates an empty tree", function()
    table = {
      key = 1,
      left = nil,
      right = nil
    }
    assert.are.same(table, tree.empty())
  end)
end)
