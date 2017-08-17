class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc
    @store = []
    #prc stored as instance variable
  end

  def count
    @store.length
  end

  def extract
    raise "empty heap" if count == 0
    val = @store[0] #returns first value

   if count > 1 ##if stuff in store
     @store[0] = @store.pop
     #takes last item in store and puts it in the first entry
     BinaryMinHeap.heapify_down(@store, 0, &@prc)
   else
     @store.pop
   end
    val
  end

  def peek
    raise 'empty heap' if count == 0
    @store.first
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1, @prc)
  end

  public
  def self.child_indices(len, parent_index)
     children = []
     idx1 = (2 * parent_index) + 1
     idx2 = (2 * parent_index) + 2

     children << idx1 if idx1 < len
     children << idx2 if idx2 < len
     children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    children = self.child_indices(len, parent_idx)

    if children.all? { |idx| prc.call(array[parent_idx], array[idx]) <= 0 }
      return array
    end

    if children.length == 1
      pivot_idx = children.first
    else
      child_values = [array[children[0]], array[children[1]]]
      pivot_idx = prc.call(child_values[0], child_values[1]) == -1 ?
      children[0] : children[1]
    end

    array[parent_idx], array[pivot_idx] = array[pivot_idx], array[parent_idx]
    self.heapify_down(array, pivot_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if child_idx == 0

    parent_idx = self.parent_index(child_idx)

    if prc.call(array[parent_idx], array[child_idx]) > 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      self.heapify_up(array, parent_idx, len, &prc)
    else
      return array
    end
  end
end
