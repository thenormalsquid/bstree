# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples'
require 'shared_examples/successor'
require 'shared_examples/predecessor'

require_relative '../lib/iterative_node'

RSpec.describe IterativeNode do
  it_inserts_like 'insertion'
  it_finds_extremes 'extreme elements'

  it_finds '#successor'
  it_finds '#predecessor'
end
