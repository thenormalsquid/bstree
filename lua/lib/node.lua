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

function Node:search(key)
  if self.key == key then return self end

  if self.left and key < self.key then
    return self.left:search(key)
  else
    if self.right then
      return self.right:search(key)
    end
  end
  return nil
end

function Node:is_present(key)
  if self.key == key then return true end

  if self.left and key < self.key then
    return self.left:is_present(key)
  else
    if self.right then
      return self.right:is_present(key)
    end
  end
  return false
end

function Node:collect(collector)
  if self.left then self.left:collect(collector) end
  collector[#collector + 1] = self.key
  if self.right then self.right:collect(collector) end
end

function Node:maximum()
  if (self.right == nil) then
    return self
  else
    return self.right:maximum()
  end
end

function Node:minimum()
  if (self.left == nil) then
    return self
  else
    return self.left:minimum()
  end
end

return Node
