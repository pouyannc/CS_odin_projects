# CS_odin_projects

A bit of computer science.

Recursion
Practice recursive algorithms using a fibonacci sequence problem and merge sort. 

Linked Lists
Easing into constructing data structures using list and node classes 

Binary Search Trees
Constructing BST using tree and node classes. Writing an assortment of methods for breadth-first and depth-first tree traversal, insertions and deletions, rebalancing the tree, etc.

Knights Travails
Return the shortest path the knight can take from the given start and end points.
This one was quite tricky. I ended up constructing the full graph first with each node being a board square. Then it was time for a search algorithm. I started thinking about breadth-first search, and realized it gets me to the end point and the lowest depth level. However, returning that path seemed so complicated. I realized I could keep track of the depth of the end point after breadth-first search, then use that as the maximum number of steps in a depth-first search to obtain the path. Used iteration in the path search algorithm since recursion might have used too much memory (deep stack level).