require 'spec_helper'
require_relative '../lib/stern_brocot'

RSpec.describe SternBrocot do
  it 'instantiates' do
    expect(SternBrocot.new).not_to be nil
  end

  describe '.rationalize' do
    context 'integers >= 0' do
      example '0' do
        actual = SternBrocot.rationalize 0
        expect(actual).to eq [0, 1]
      end

      example '1' do
        actual = SternBrocot.rationalize 1
        expect(actual).to eq [1, 1]
      end

      example '2' do
        actual = SternBrocot.rationalize 2
        expect(actual).to eq [2, 1]
      end

      example '1246' do
        actual = SternBrocot.rationalize 1246
        expect(actual).to eq [1246, 1]
      end
    end

    context 'rational numbers <= 1.0' do
      example '0.0'
      example '1.0'
      example '0.5'
      example '1.5'
      example '0.3'
      example '0.33'
    end

    context 'rational numbers > 1.0' do
      example '1.1'
      example '3.1'
      example '5.2'
      example '9.9'
      example '123.123'
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
