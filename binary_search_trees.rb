class Node
  
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

end

class Tree

  attr_accessor :root, :arr

  def initialize(arr)
    @arr = arr.uniq.sort
    @root = sorted_array_to_BST(@arr)
  end

  def sorted_array_to_BST(arr)
    return nil if arr.class != Array || arr.length < 1
  
    arr = arr.uniq
  
    mid = arr.length / 2
  
    root = Node.new(arr[mid])
    root.left = sorted_array_to_BST(arr[0...mid])
    root.right = sorted_array_to_BST(arr[mid + 1...arr.length])
  
    return root
  end

  def insert(value, node = @root)
    if value == node.value
      return nil
    elsif value < node.value
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    elsif value > node.value
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    if node == @root && node.value == value
      @root = delete_node(@root)
    end

    if value < node.value
      node.left.value == value ? node.left = delete_node(node.left) : delete(value, node.left) 
    elsif value > node.value
      node.right.value == value ? node.right = delete_node(node.right) : delete(value, node.right)
    end

    return nil
  end

  def delete_node(node)
    # return node that should replace deleted node
    if node.left.nil? && node.right.nil?
      nil
    elsif node.left.nil?
      node.right
    elsif node.right.nil?
      node.left
    else
      replacement_node = find_closest_value_node(node.right)
      self.delete(replacement_node.value)
      replacement_node.left, replacement_node.right = node.left, node.right
      replacement_node
    end
  end

  def find_closest_value_node(node)
    # must be given the right tree of node
    if node.left.nil?
      #puts "closest node: #{node.value}"
      return node
    else
      find_closest_value_node(node.left)
    end
    return node
  end

  def find(value, node = @root)
    if value == node.value
      return node
    elsif value < node.value
      find(value, node.left)
    else
      find(value, node.right)
    end
    return nil      
  end

  def level_order(node = @root, queue = [@root], values = [], &b)
    unless queue.empty?
      b.call(queue[0]) if block_given?
      values.push(node.value)
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
      queue.shift
      level_order(queue[0], queue, values, &b) 
    end
    return values unless block_given?
  end

  def preorder(node = @root, values = [], &b)
    #DLR
    unless node.nil?
      b.call(node) if block_given?
      values.push(node.value)
      preorder(node.left, values, &b)
      preorder(node.right, values, &b)
    end
    return values unless block_given?
  end

  def inorder(node = @root, values = [], &b)
    #LDR
    unless node.nil?
      inorder(node.left, values, &b)
      b.call(node) if block_given?
      values.push(node.value)
      inorder(node.right, values, &b)
    end
    return values unless block_given?
  end

  def postorder(node = @root, values = [], &b)
    #LRD
    unless node.nil?
      postorder(node.left, values, &b)
      postorder(node.right, values, &b)
      b.call(node) if block_given?
      values.push(node.value)
    end
    return values unless block_given?
  end

  def height(node, h = 0)
    return nil if node.nil?

    return h if node.left.nil? && node.right.nil?

    if node.right.nil?
      h += 1
      return height(node.left, h)
    elsif node.left.nil?
      h += 1
      return height(node.right, h)
    else
      h += 1
      r_path = height(node.right, h)
      l_path = height(node.left, h)
      r_path > l_path ? (return r_path) : (return l_path)
    end
  end

  def depth(node)
    return nil if node.nil?
    d = 0
    current_node = @root
    while node != current_node do
      d += 1
      node.value < current_node.value ? current_node = current_node.left : current_node = current_node.right
    end
    return d
  end

  def balanced?
  end

  def rebalance
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end



new_tree = Tree.new([7,6,5,8,4,1,2,3])
new_tree.pretty_print
new_tree.insert(10)
new_tree.insert(9)
new_tree.pretty_print
new_tree.delete(6)
new_tree.pretty_print
new_tree.delete(2)
new_tree.pretty_print
new_tree.delete(5)
new_tree.pretty_print

puts 'level order traversal: '
new_tree.level_order { |node| print node.value }

p new_tree.preorder
p new_tree.inorder
p new_tree.postorder

p new_tree.depth(new_tree.root.left)
p new_tree.height(new_tree.root)

