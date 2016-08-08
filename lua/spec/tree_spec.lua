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
  pending("it inserts a left node into a rooted tree")
  pending("it inserts a right node into a rooted tree")
end)

describe("searches tree for node with specified key", function()
  pending("returns nil for an empty tree")
  pending("finds the root node by key")
  pending("finds the left node for two nodes")
  pending("finds the right node for two nodes")
  pending("finds leaf node in tree of height 3")
end)

describe("collects values in key order", function()
  pending("returns nil for an empty tree")
  pending("return the root for a single node")
  pending("return the left and root for two nodes")
  pending("return the right and root for two nodes")
  pending("return in order list of tree with height 3")
end)

describe("deletes a node from the tree", function()
  pending("deletes root when 1 node tree")
end)
