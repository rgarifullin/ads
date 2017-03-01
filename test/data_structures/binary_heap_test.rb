require 'minitest/autorun'
require 'data_structures/binary_heap'

describe DataStructures::BinaryHeap do
  def valid?(heap)
    heap.each_with_index do |_, i|
      left = 2 * i + 1
      right = 2 * i + 2

      if heap[left] && heap[right] && (heap[i] <= heap[left] ||
                                       heap[i] <= heap[right])
        return false
      end
      return false if heap[left] && heap[i] <= heap[left]
      return false if heap[right] && heap[i] <= heap[right]
    end

    true
  end

  let(:array) do
    [7, 12, 3, 14, 18, 2, 15, 11, 9, 6]
  end

  let(:sample) do
    [18, 14, 15, 11, 12, 2, 3, 7, 9, 6]
  end

  subject do
    DataStructures::BinaryHeap.new(array)
  end

  describe '#pop' do
    it 'returns root element' do
      subject.pop.must_equal sample.first
    end
  end

  describe '#initialize' do
    it 'reorganizes entries' do
      valid?(subject.inspect).must_equal true
      subject.inspect.must_equal sample
    end

    it 'do nothing with already ordered entries' do
      DataStructures::BinaryHeap.new(sample).inspect.must_equal sample
    end
  end

  describe '#insert' do
    it 'reorganizes entries after insert' do
      subject.insert(20)

      valid?(subject.inspect).must_equal true
      subject.pop.must_equal 20
    end
  end

  describe '#extract' do
    it 'reorganizes entries after extract' do
      extracted = subject.extract(18)

      extracted.must_equal 18
      valid?(subject.inspect).must_equal true
      subject.pop.must_equal 15
    end
  end

  describe '#sort' do
    it 'returns sorted array' do
      subject.sort.must_equal array.sort { |l, r| r <=> l }
    end
  end
end
