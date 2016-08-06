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

describe("collecting values or labels from nodes in order", function()
  it("collects the value from a single node", function()
    root = node:new(11)
    actual = {}
    root:collect(actual)
    expected = {11}
    assert.are.same(expected, actual)
  end)

  it("collects the value from root and right child", function()
    root = node:new(11)
    n17 = node:new(17)
    root:insert(n17)

    actual = {}
    root:collect(actual)
    expected = {11, 17}
    assert.are.same(expected, actual)
  end)

  it("collects the value from root and left child", function()
    root = node:new(11)
    n7 = node:new(7)
    root:insert(n7)

    actual = {}
    root:collect(actual)
    expected = {7, 11}
    assert.are.same(expected, actual)
  end)

  it("collects the values from arbitrary tree", function()
    root = node:new(11)
    n17 = node:new(17)
    n13 = node:new(13)
    n5 = node:new(5)
    n7 = node:new(7)
    root:insert(n17)
    root:insert(n13)
    root:insert(n5)
    root:insert(n7)

    actual = {}
    root:collect(actual)
    expected = {5, 7, 11, 13, 17}
    assert.are.same(expected, actual)
  end)
end) 
