require 'minitest/autorun'
require 'algorithms/sort'

describe Algorithms::Sort do
  subject do
    Algorithms::Sort
  end

  let(:array) { Array.new(10) { rand(1..50) } }

  describe '.mergesort' do
    it 'sorts array' do
      subject.mergesort(array).must_equal array.sort
    end
  end

  describe '.bin_heapsort' do
    it 'sorts array' do
      subject.bin_heapsort(array).must_equal array.sort { |l, r| r <=> l }
    end
  end

  describe '.binom_heapsort' do
    it 'sorts array' do
      subject.binom_heapsort(array).map(&:value).must_equal array.sort
    end
  end
end
