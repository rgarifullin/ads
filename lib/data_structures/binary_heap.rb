module DataStructures
  # Binary heap is complete binary tree. Value of each node is greater than or
  # equal to value of child node for max heap and less than or equal to for
  # min heap. Default is max heap mode.
  class BinaryHeap
    def initialize(entries = [], compare = default_compare)
      @heap = []
      @compare = compare
      return if entries.empty?

      @heap.concat(entries)
      construct
    end

    def insert(entry)
      @heap << entry

      i = @heap.size - 1
      parent = parent_index(i)

      while !parent.negative? && @compare.call(@heap[parent], @heap[i])
        @heap[parent], @heap[i] = @heap[i], @heap[parent]
        i = parent
        parent = parent_index(parent)
      end
    end

    # FIXME: is this method relevant (and correct)?
    def extract(entry)
      i = @heap.find_index(entry)
      extracted = @heap[i]
      @heap[i] = @heap.delete_at(@heap.size - 1)
      heapify(i)
      extracted
    end

    def pop!
      if @heap.size == 1
        extracted = pop
        @heap.clear
        return extracted
      end

      extracted = pop
      @heap[0] = @heap.delete_at(@heap.size - 1)
      heapify(0)
      extracted
    end

    def pop
      @heap.first
    end

    def inspect
      @heap
    end

    def sort
      Array.new(@heap.size) { pop! }
    end

    private

    def heapify(i)
      left = left_child_index(i)
      right = right_child_index(i)

      if @heap[left] && @heap[right] && (@compare.call(@heap[i], @heap[left]) ||
                                         @compare.call(@heap[i], @heap[right]))
        swap(@compare.call(@heap[right], @heap[left]) ? left : right, i)
      elsif @heap[left] && @compare.call(@heap[i], @heap[left])
        swap(left, i)
      elsif @heap[right] && @compare.call(@heap[i], @heap[right])
        swap(right, i)
      end
    end

    def swap(i, j)
      @heap[i], @heap[j] = @heap[j], @heap[i]
      heapify(i)
    end

    def construct
      max_index = (@heap.size / 2) - 1
      max_index.downto(0).each do |i|
        heapify(i)
      end
    end

    def default_compare
      ->(a, b) { a <= b }
    end

    def parent_index(i)
      (i - (i.odd? ? 1 : 2)) / 2
    end

    def left_child_index(i)
      2 * i + 1
    end

    def right_child_index(i)
      2 * i + 2
    end
  end
end
