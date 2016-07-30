local print = print

local Node = {}

function Node:new(key)
  local node = {
    key = key,
    left = nil,
    right = nil
  }
  setmetatable(node, self)
  self.__index = self
  return node
end

function Node:insert(n)
  if n.key < self.key then
    self.left = n
  else
    self.right = n
  end
end

return Node
