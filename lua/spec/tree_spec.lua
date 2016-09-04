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

describe('find maximum or minimum', function()
  setup(function()
    root = node:new(13)
    t = tree:new(root)
    n19 = node:new(19)
  end)

  it('returns nil for maximum and minimum of empty tree', function()
    local t = tree:new(nil)
    assert.are.same(nil, t:maximum())
    assert.are.same(nil, t:minimum())
  end)

  it('finds maximum and minimum same in single node tree', function()
    assert.are.same(root, t:maximum())
    assert.are.same(root, t:minimum())
  end)

  it('finds minimum left child and maximum right child', function()
    local n7 = node:new(7)
    t:insert(n7)
    t:insert(n19)
    assert.are.same(n7, t:minimum())
    assert.are.same(n19, t:maximum())
  end)

  it("finds the value from root and right child", function()
    local n17 = node:new(17)
    local n3 = node:new(3)
    local n5 = node:new(5)
    t:insert(n17)
    t:insert(n3)
    t:insert(n5)

    assert.are.same(n3, t:minimum())
    assert.are.same(n19, t:maximum())
  end)
end)

describe("searches tree for node with specified key", function()
  setup(function()
    local root = node:new(11)
    t = tree:new(root)
  end)

  it("returns nil for an empty tree", function()
    local t = tree:new(nil)
    assert.are.same(nil, t:search(42))
    assert.are.same(false, t:is_present(42))
  end)

  it("finds the value from a single node", function()
    assert.are.same(t.root, t:search(11))
    assert.are.same(true, t:is_present(11))
  end)

  it("finds the value from root and right child", function()
    local n17 = node:new(17)
    t:insert(n17)
    assert.are.same(n17, t:search(17))
    assert.are.same(true, t:is_present(17))

    local n7 = node:new(7)
    t:insert(n7)
    assert.are.same(n7, t:search(7))
    assert.are.same(true, t:is_present(7))

    local n3 = node:new(3)
    t:insert(n3)
    local n5 = node:new(5)
    t:insert(n5)
    local n19 = node:new(19)
    t:insert(n19)
    assert.are.same(n3, t:search(3))
    assert.are.same(true, t:is_present(3))
    assert.are.same(n5, t:search(5))
    assert.are.same(true, t:is_present(5))
    assert.are.same(n19, t:search(19))
    assert.are.same(true, t:is_present(19))
    assert.are.same(nil, t:search(42))
  end)
end)

describe("collects values in key order", function()
  setup(function()
    local root = node:new(11)
    t = tree:new(root)
  end)

  it("returns nil for an empty tree", function()
    local t = tree:new(nil)
    actual = {}
    t:collect({})
    assert.are.same({}, actual)
  end)

  it("collects the value from a single node", function()
    actual = {}
    t:collect(actual)
    expected = {11}
    assert.are.same(expected, actual)
  end)

  it("collects the value from root and right child", function()
    local n17 = node:new(17)
    t:insert(n17)

    actual = {}
    t:collect(actual)
    expected = {11, 17}
    assert.are.same(expected, actual)
  end)

  it("collects the value from root and right and left child", function()
    local n7 = node:new(7)
    t:insert(n7)

    actual = {}
    t:collect(actual)
    expected = {7, 11, 17}
    assert.are.same(expected, actual)
  end)

  it("return in order list of tree with height 3", function()
    local n3 = node:new(3)
    t:insert(n3)
    local n5 = node:new(5)
    t:insert(n5)
    local n19 = node:new(19)
    t:insert(n19)

    actual = {}
    t:collect(actual)
    expected = {3, 5, 7, 11, 17, 19}
    assert.are.same(expected, actual)
  end)
end)

describe("deletes a node from the tree", function()
  pending("deletes root when 1 node tree")
end)

describe(":successor", function()
  it("finds root successor for single node", function()
    local root = node:new(17)
    local t = tree:new(root)
    assert.are.same(root, t:successor(root))
  end)
end)

describe(":height", function()
  setup(function()
    local root = node:new(11)
    t = tree:new(root)
  end)

  it("tree with 1 node has height 0", function()
    assert.are.same(0, t:height())
  end)

  it("tree with two nodes has height 1", function()
    local n3 = node:new(3)
    t:insert(n3)
    assert.are.same(1, t:height())
  end)
end)

describe(":size", function()
  it("tree with 1 node is size 1", function()
    local root = node:new(11)
    local t = tree:new(root)
    assert.are.same(1, t:size())
  end)
end)
