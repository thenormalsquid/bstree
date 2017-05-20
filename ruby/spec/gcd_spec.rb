require 'spec_helper'

require_relative '../lib/gcd'

RSpec.describe Gcd do
  describe '.compute' do
    it 'finds 21 for 1071, 462' do
      expect(Gcd.compute(1071, 462)).to eq 21
    end

    example 'gcd(2, 1)' do
      expect(Gcd.compute(2, 1)).to eq 1
    end

    example 'gcd(4, 2)' do
      expect(Gcd.compute(4, 2)).to eq 2
    end

    example 'gcd(17, 1)' do
      expect(Gcd.compute(17, 1)).to eq 1
    end

    example 'gcd(48, 18)' do
      expect(Gcd.compute(48, 18)).to eq 6
    end

    example 'gcd(18, 48)' do
      expect(Gcd.compute(18, 48)).to eq 6
    end

    example 'gcd(18, 0)' do
      expect(Gcd.compute(18, 0)).to eq 18
    end

    example 'gcd(0, 18)' do
      expect(Gcd.compute(0, 18)).to eq 18
    end
  end

  describe '.coprime?' do
    example 'coprime(17, 1)' do
      expect(Gcd.coprime?(17, 1)).to be true
    end

    example 'coprime(3, 5)' do
      expect(Gcd.coprime?(3, 5)).to be true
    end

    example 'coprime(6, 8)' do
      expect(Gcd.coprime?(6, 8)).to be false
    end
  end
end
