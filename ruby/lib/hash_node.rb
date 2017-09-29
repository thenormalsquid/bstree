# frozen_string_literal: true

require 'digest'

class HashNode
  attr_accessor :hash, :key, :left, :right, :parent
end
