# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples'

require_relative '../lib/iterative_node'

RSpec.describe IterativeNode do
  it_inserts_like 'insertion'
  it_finds_extremes 'extreme elements'
end
