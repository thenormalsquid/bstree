require 'busted.runner'()

tree = require 'lib/tree'
node = require 'lib/node'

describe("instantiating trees", function()
  it("instantiates an empty tree", function()
    table = {
      key = nil,
      left = nil,
      right = nil
    }
    assert.are.same(table, tree:empty())
  end)

  it("creates a tree with a root node", function()
    root = node:new(11)
    local t = tree:new(root)
    assert.are.same(root, t.root)
  end)
end)

describe("insert nodes into tree", function()
  setup(function()
    local root = node:new(11)
    t = tree:new(root)
  end)

  it("it inserts a right node into a rooted tree", function()
    local n17 = node:new(17)
    t:insert(n17)
    assert.are.same(n17, t.root.right)
  end)

  it("it inserts a right node into a rooted tree", function()
    local n5 = node:new(5)
    t:insert(n5)
    assert.are.same(n5, t.root.left)
  end)

  it("it inserts a right then a left node into a rooted tree", function()
    local n13 = node:new(13)
    t:insert(n13)
    assert.are.same(n13, t.root.right.left)
  end)

  it("it inserts a left then a right node into a rooted tree", function()
    local n7 = node:new(7)
    t:insert(n7)
    assert.are.same(n7, t.root.left.right)
  end)
end)

describe("searches tree for node with specified key", function()
  pending("returns nil for an empty tree")
  pending("finds the root node by key")
  pending("finds the left node for two nodes")
  pending("finds the right node for two nodes")
  pending("finds leaf node in tree of height 3")
end)

describe("collects values in key order", function()
  setup(function()
    local root = node:new(11)
    t = tree:new(root)
  end)

  it("collects the value from a single node", function()
    actual = {}
    t:collect(actual)
    expected = {11}
    assert.are.same(expected, actual)
  end)

  it("collects the value from root and right child", function()
    n17 = node:new(17)
    t:insert(n17)

    actual = {}
    t:collect(actual)
    expected = {11, 17}
    assert.are.same(expected, actual)
  end)

  it("collects the value from root and left child", function()
    n7 = node:new(7)
    t:insert(n7)

    actual = {}
    t:collect(actual)
    expected = {7, 11, 17}
    assert.are.same(expected, actual)
  end)

  it("returns nil for an empty tree", function()
    local t = tree:new(nil)
    actual = {}
    t:collect({})
    assert.are.same({}, actual)
  end)

  pending("return the root for a single node")
  pending("return the left and root for two nodes")
  pending("return the right and root for two nodes")
  pending("return in order list of tree with height 3")
end)

describe("deletes a node from the tree", function()
  pending("deletes root when 1 node tree")
end)

describe(":size", function()
  setup(function()
    local root = node:new(11)
    t = tree:new(root)
  end)

  it("determine size for various trees", function()
    local root = node:new(11)
    -- assert.are.same(1, tree:size())

    n17 = node:new(17)
    t:insert(n17)
    -- assert.are.same(2, tree:size())

    n13 = node:new(13)
    t:insert(n13)
    -- assert.are.same(3, tree:size())

    n5 = node:new(5)
    t:insert(n5)
    -- assert.are.same(4, tree:size())

    n7 = node:new(7)
    t:insert(n7)
    -- assert.are.same(5, tree:size())
  end)
end)
