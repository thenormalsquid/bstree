require_relative './node'

class Tree
  attr_reader :root

  def initialize node = nil
    @root = node ? node : Node.new
  end

  def add node
    @root.add node
  end 
end
