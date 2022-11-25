class Node

  attr_accessor :coord, :neighbours

  def initialize(coord)
    @coord = coord
    @neighbours = []
  end

  def add_edge(neighbour)
    @neighbours.push(neighbour)
  end

end

class Graph

  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def add_node(coord)
    @nodes.push(Node.new(coord))
  end

  def find_node(coord)
    nodes.each {|node| return node if node.coord == coord}
    return nil
  end

end

def find_least_steps(start_node, end_node)
  queue = [start_node]
  steps = 0
  edges = 1
  loop do
    if queue[0] == end_node
      return steps
    else
      queue.push(queue[0].neighbours).flatten!
      queue.shift
      edges -= 1
      if edges == 0
        edges = queue.length 
        steps += 1
      end
    end
  end
end

def find_shortest_path(node, end_node, steps, n_length = [], path = [], queue = [])
  loop do
    path.push(node)
    if steps == 0 && path[-1] == end_node
      return path
    elsif steps == 0
      queue.shift
      path.pop
      n_length[0] -= 1
      while n_length[0] == 0 do
        path.pop
        queue.shift
        n_length.shift
        n_length[0] -= 1
        steps += 1
      end
      node = queue[0]
    else
      steps -= 1
      queue.unshift(node.neighbours).flatten!
      n_length.unshift(node.neighbours.length)
      node = queue[0]
    end
  end
end

def knight_moves(start, finish)

  moves = [[-1,-2], [-2,-1], [-2,1], [-1,2], [1,2], [2,1], [2,-1], [1,-2]]
  path = [start]

  knight_move_graph = Graph.new
  8.times do |i|
    8.times do |j|
      knight_move_graph.add_node([i,j])
    end
  end

  knight_move_graph.nodes.each do |node|
    moves.each do |move|
      neighbour_coord = [node.coord, move].transpose.map {|x| x.reduce(:+)}
      if neighbour_coord[0].between?(0,7) && neighbour_coord[1].between?(0,7)
        node.add_edge(knight_move_graph.find_node(neighbour_coord)) 
      end
    end
  end

  start_node = knight_move_graph.find_node(start)
  end_node = knight_move_graph.find_node(finish)

  steps = find_least_steps(start_node, end_node)

  return find_shortest_path(start_node, end_node, steps).map {|n| n.coord}
  
end

p knight_moves([0,3], [6,3])
