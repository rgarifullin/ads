require_relative '../data_structures/binary_heap'

module Algorithms
  module Sort
    def self.mergesort(ar)
      size = ar.length
      return ar if size == 1
      return min_sort(ar.first, ar.last) if size == 2

      mid = size / 2
      left = mergesort(ar[0...mid])
      right = mergesort(ar[mid..(size - 1)])

      res = []
      while left&.any? && right&.any?
        res << (left.first < right.first ? left.shift : right.shift)
      end
      res + left + right
    end

    def self.min_sort(left, right)
      left < right ? [left, right] : [right, left]
    end

    def self.heapsort(ar)
      DataStructures::BinaryHeap.new(ar).sort
    end
  end
end
