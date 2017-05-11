require 'spec_helper'
require_relative '../lib/stern_brocot'

RSpec.describe SternBrocot do
  it 'instantiates' do
    expect(SternBrocot.new).not_to be nil
  end

  describe '.rationalize' do
    context 'integers' do
      example '0'
      example '1'
      example '2'
      example '1246'
    end

    context 'rational numbers' do
      example '0.0'
      example '1.0'
      example '0.5'
      example '1.5'
      example '0.3'
      example '0.33'
    end

    context 'irrational numbers' do
      context 'pi' do
        example 'to 1 decimal place'
        example 'to 2 decimal places'
        example 'to 3 decimal places'
        example 'to 4 decimal places'
        example 'to 5 decimal places'
      end

      context 'e' do
        example 'to 1 decimal place'
        example 'to 2 decimal places'
        example 'to 3 decimal places'
        example 'to 4 decimal places'
        example 'to 5 decimal places'
      end
    end
  end
end
