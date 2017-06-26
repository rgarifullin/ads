require_relative '../data_structures/binary_heap'
require_relative '../data_structures/binomial_heap'

module Algorithms
  # Sort algorithms
  module Sort
    def self.mergesort(ar)
      size = ar.length
      return ar if size == 1
      return min_sort(ar.first, ar.last) if size == 2

      left = mergesort(ar[0...(size / 2)])
      right = mergesort(ar[(size / 2)..(size - 1)])

      res = []
      while left&.any? && right&.any?
        res << (left.first < right.first ? left.shift : right.shift)
      end
      res + left + right
    end

    def self.min_sort(left, right)
      left < right ? [left, right] : [right, left]
    end

    def self.bin_heapsort(ar)
      DataStructures::BinaryHeap.new(ar).sort
    end

    def self.binom_heapsort(ar)
      DataStructures::BinomialHeap.new(ar).sort
    end
  end
end
