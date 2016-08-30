# frozen_string_literal: true
require 'ap'
require 'pry'

RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_has_behavior, 'has behavior:'
end
