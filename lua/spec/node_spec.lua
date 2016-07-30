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

  it("inserts left and right nodes", function()
    root = node:new(11)
    right = node:new(13)
    left = node:new(5)
    root:insert(right)
    root:insert(left)
    assert.are.same(root.right, right)
    assert.are.same(root.left, left)
  end)

  it("inserts left and right nodes recursively", function()
    root = node:new(11)
    n17 = node:new(17)
    n13 = node:new(13)
    n5 = node:new(5)
    n7 = node:new(7)
    root:insert(n17)
    root:insert(n13)
    root:insert(n5)
    root:insert(n7)
    assert.are.same(root.right, n17)
    assert.are.same(root.right.left, n13)
    assert.are.same(root.left, n5)
    assert.are.same(root.left.right, n7)
  end)
end)


