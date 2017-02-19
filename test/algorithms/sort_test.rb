require 'minitest/autorun'
require 'algorithms/sort'

describe Algorithms::Sort do
  subject do
    Algorithms::Sort
  end

  let(:array) { Array.new(10) { rand(1..50) } }

  it 'sorts array of integers by asc order' do
    subject.mergesort(array).must_equal array.sort
  end
end