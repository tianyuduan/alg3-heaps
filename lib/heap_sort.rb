require_relative "heap"

class Array
  def heap_sort!
    raise "sorted" if count <= 1

    2.upto(count).each do |heap_i|
      BinaryMinHeap.heapify_up(self, heap_i - 1, heap_i)
    end

    partition = count
    until partition == 0
      self[partition - 1], self[0] = self[0], self[partition - 1]

      partition -= 1

      BinaryMinHeap.heapify_down(self, 0, partition)
    end

    self.reverse!
  end
end
