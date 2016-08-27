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

function Node:post_order_traverse(callback)
  if self.left then self.left:post_order_traverse(callback) end
  if self.right then self.right:post_order_traverse(callback) end
  callback()
end

function Node:get_height(height, max)
  current = height + 1
  if self.left then max = self.left:get_height(current, max) end
  if self.right then max = self.right:get_height(current, max) end
  current = current - 1
  if current > max then max = current end
  return max
end

function Node:height()
  return self:get_height(0, 0)
end

function Node:size()
  size = 0
  self:post_order_traverse(function () size = size + 1 end)
  return size
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
