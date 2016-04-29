class Node
  attr_accessor :left, :right, :value

  def initialize value = nil
    @value = value
  end

  def <=> other
    return -1 if other.value < self.value
    other.value == value ? 0 : 1
  end
end
