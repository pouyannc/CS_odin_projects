class LinkedList 

  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
    elsif @head.next_node.nil?
      @tail = Node.new(value)
      @head.next_node = @tail
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
    elsif @head.next_node.nil?
      @tail = @head
      @head = Node.new(value)
      @head.next_node = @tail
    else
      @head = Node.new(value, @head)
    end
  end

  def size(node = @head, l = 0)
    if node.nil?
      return l
    else
      l += 1
      size(node.next_node, l)
    end
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def at(index, node = @head, i = 0)
    if i == index
      return node
    else
      i += 1
      at(index, node.next_node, i)
    end
  end

  def pop
    @tail = self.at(self.size - 2)
    @tail.next_node = nil
  end
  
  def contains?(value, node = @head)
    if node.nil?
      return false
    elsif node.value == value
      return true
    else
      contains?(value, node.next_node)
    end
  end

  def find(value, node = @head, i = 0)
    if node.nil?
      return nil
    elsif node.value == value
      return i
    else
      i += 1
      find(value, node.next_node, i)
    end
  end

  def to_s(node = @head, string = '')
    if node.nil?
      string += 'nil'
    else
      string += "( #{node.value} ) -> "
      to_s(node.next_node, string)
    end    
  end

  def insert_at(value, index)
    if index >= self.size
      self.append(value)
    else
      self.at(index - 1).next_node = Node.new(value, self.at(index))
    end
  end

  def remove_at(index)
    if index >= self.size
      self.pop
    else
      self.at(index - 1).next_node = self.at(index + 1)
    end
  end

end

class Node

  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

end

new_list = LinkedList.new
new_list.append(0)
new_list.append(1)
new_list.append("tail")
new_list.prepend("head")
p new_list.head
p new_list.tail
p new_list.size
p new_list.at(2)
new_list.pop
p new_list.contains?("tail")
p new_list.contains?(1)
p new_list.find(0)
puts new_list.to_s
new_list.insert_at('insert', 2)
puts new_list.to_s
new_list.remove_at(1)
puts new_list.to_s