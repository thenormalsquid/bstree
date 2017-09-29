# frozen_string_literal: true

require 'digest'

class HashValue
  attr_accessor :hash, :data, :parent, :left, :right
end
