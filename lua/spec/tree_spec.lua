require 'busted.runner'()

tree = require 'lib/tree'
node = require 'lib/node'

describe("instantiating trees", function()
  it("instantiates an empty tree", function()
    table = {
      key = 1,
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
  pending("it inserts a node into a rooted tree")
end)

describe("searches tree for node with specified key", function()
  pending("finds the root node by key")
end)

describe("collects values in key order", function()
  pending("prints out the root for a single node")
end)
