require_relative 'heap'

def k_largest_elements(array, k)

      length = array.length;
      h = BinaryMinHeap.new
      array.each do |el|
        h.push(el)
      end
       return h
end
