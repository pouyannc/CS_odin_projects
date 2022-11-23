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

  
  
end

knight_moves([0,0], [0,0])