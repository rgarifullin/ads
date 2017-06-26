module DataStructures
  # Binomial heap is a list of of binomial trees with following properties:
  # 1) Value of each node is greater (less) or equal to value of parent node.
  # 2) Tree of order k has 2^k nodes.
  class BinomialHeap
    attr_reader :heads

    def initialize(entries = [], compare = default_compare)
      @heads = []
      @compare = compare
      entries.each { |entry| insert(entry) }
    end

    def insert(entry)
      @heads << Node.new(entry)
      merge_all
      @heads.sort_by!(&:degree)
    end

    def pop
      return if @heads.empty?

      min = @heads.first
      @heads.each { |tree| min = tree if @compare.call(tree, min) }

      min
    end

    def pop!
      min = pop
      return unless min

      left_child = min&.left
      if left_child
        children = [left_child]
        next_child = left_child.sibling
        while next_child && next_child != left_child
          children << next_child
          next_child = next_child.sibling
        end

        uplevel(min, children)

        @heads.sort_by!(&:degree)
        merge_all
      else
        @heads.delete_at(0)
      end

      min
    end

    def sort
      sorted = []

      sorted << pop! while @heads.any?

      sorted
    end

    def inspect
      @heads.map { |h| min_inspect(h) }
    end

    private

    def min_inspect(node)
      if node.left && node.sibling
        [[node, min_inspect(node.left)], min_inspect(node.sibling)]
      elsif node.left
        [node, min_inspect(node.left)]
      elsif node.sibling
        min_inspect(node.sibling)
      else
        node
      end
    end

    def uplevel(min, children)
      children.each do |child|
        child.parent = nil
        child.sibling = nil
      end
      last_min_pos = @heads.find_index(min)
      @heads[last_min_pos] = children[0]
      children[1..-1].reverse_each { |c| @heads.insert(last_min_pos, c) }
    end

    def merge_all
      return if @heads.size < 2

      (0..(@heads.size - 2)).each do |i|
        ((i + 1)..(@heads.size - 1)).each do |j|
          loop do
            break if @heads[i]&.degree != @heads[j]&.degree

            merge(i, j)
          end
        end
      end
    end

    def merge(i, j)
      @compare.call(@heads[i], @heads[j]) ? adopt(i, j) : adopt(j, i)
    end

    def adopt(i, j)
      if @heads[i].left
        left = @heads[i].left
        @heads[i].left = @heads[j]
        @heads[i].left.sibling = left
      else
        @heads[i].left = @heads[j]
      end

      @heads[i].degree += 1

      @heads.delete_at(j)
    end

    def default_compare
      ->(a, b) { a.value <= b.value }
    end

    # Node of binomial heap.
    class Node
      attr_accessor :parent, :left, :sibling, :value, :degree

      def initialize(entry)
        @value = entry
        @degree = 0
      end
    end
  end
end
