-- Tree is a container for a binary search tree.
-- Its primary function is to manage the root node.

local print = print

local Tree = {}

-- Don't remember why this function was implemented
function Tree:empty()
  return {
    key = 1,
    left = nil,
    right = nil
  }
end

function Tree:new(node)
  local tree = {
    root = node,
  }
  setmetatable(tree, self)
  self.__index = self
  return tree
end

function Tree:insert(node)
  self.root:insert(node)
end

return Tree
