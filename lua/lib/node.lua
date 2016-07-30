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
    if self.left == nil then
      self.left = n
    else
      self.left:insert(n)
    end
  else
    if self.right == nil then
      self.right = n
    else
      self.right:insert(n)
    end
  end
end

return Node
