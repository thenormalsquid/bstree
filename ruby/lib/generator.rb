# frozen_string_literal: true
require_relative './tree'
require_relative './node'

class Generator
  def build nodes
    tree = Tree.new(Node.new(nodes.shift))
    nodes.each { |n| tree.insert(Node.new(n)) }
    tree
  end

  def self.tree1
    Generator.new.build [11]
  end

  def self.tree2
    Generator.new.build [11, 7]
  end

  def self.tree3
    Generator.new.build [11, 7, 13]
  end

  def self.tree4
    Generator.new.build [11, 7, 5]
  end

  def self.tree5
    Generator.new.build [5, 7, 11]
  end

  def self.tree6
    Generator.new.build [11, 5, 3, 7, 13]
  end

  def self.tree7
    Generator.new.build [5, 3, 11, 7, 13]
  end

  def self.tree8
    Generator.new.build [11, 5, 3, 7, 17, 13, 19]
  end

  def self.tree9
    Generator.new.build [19, 23, 13, 17, 11, 5, 7]
  end

  def self.tree10
    Generator.new.build [11, 5, 3, 19, 17, 29, 23, 41, 37, 53]
  end
end
