require 'minitest/autorun'
require 'data_structures/binomial_heap'

describe DataStructures::BinomialHeap do
  let(:array) { [13, 1, 2, 9, 10, 3, 6, 11, 12, 4, 8, 5, 7] }
  let(:sample) { [7, 4, 5, 8, 12, 1, 3, 6, 11, 10, 2, 9, 13] }

  subject do
    DataStructures::BinomialHeap.new
  end

  def nested_map(node)
    node.is_a?(Array) ? node.map { |n| nested_map(n) } : node.value
  end

  describe '#initialize' do
    subject do
      DataStructures::BinomialHeap.new(array)
    end

    it 'reorganizes entries' do
      subject.inspect.map { |n| nested_map(n) }.flatten.must_equal sample
      subject.heads.size.must_equal 3
    end
  end

  describe '#insert' do
    it 'adds element to heap' do
      subject.insert(3)
      subject.heads.size.must_equal 1
      subject.heads.first.value.must_equal 3
    end
  end

  describe '#pop' do
    it 'returns min (max) element of heap' do
      subject.insert(3)
      subject.insert(1)
      subject.insert(4)
      subject.pop.value.must_equal 1
      subject.heads.size.must_equal 2
    end
  end

  describe '#pop!' do
    subject do
      DataStructures::BinomialHeap.new(array)
    end

    it 'extracts min (max) element of heap' do
      (1..13).each do |i|
        subject.pop!.value.must_equal i
      end
      subject.pop!.must_be_nil
    end
  end
end
