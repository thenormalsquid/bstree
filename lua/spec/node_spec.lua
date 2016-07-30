require 'busted.runner'()

node = require 'lib/node'

describe("instantiating nodes", function()
  it("instantiates a node", function()
    table = {
      key = 11,
      left = nil,
      right = nil
    }
    assert.are.same(table, node:new(11))
  end)
end)

describe("insert nodes", function()
  it("inserts a single node", function()
    root = node:new(11)
    right = node:new(13)
    root:insert(right)
    assert.are.same(root.right, right)
  end)
end)


