-- Tree is a container for a binary search tree.
-- Its primary function is to manage the root node.

local print = print

local Tree = {}

-- Don't remember why this function was implemented
function Tree:empty()
  return {
    key = nil,
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

function Tree:search(key)
  if self.root == nil then return nil end
  return self.root:search(key)
end

function Tree:is_present(key)
  if self.root == nil then return false end
  return self.root:is_present(key)
end

function Tree:collect(collector)
  if self.root == nil then return end
  self.root:collect(collector)
end

function Tree:successor(node)
  if self.root == nil then return end
  return self.root:successor(node)
end

function Tree:predecessor(node)
  if self.root == nil then return end
  return self.root:predecessor(node)
end

function Tree:is_empty()
  if self.root == nil then return true else return false end
end

function Tree:is_bst()
  if self.root == nil then return true end
  return self.root:is_bst()
end

function Tree:height()
  return self.root:height()
end

function Tree:size()
  if self.root == nil then return 0 end
  return self.root:size()
end

function Tree:maximum()
  if self.root == nil then return nil end
  return self.root:maximum()
end

function Tree:minimum()
  if self.root == nil then return nil end
  return self.root:minimum()
end

return Tree
