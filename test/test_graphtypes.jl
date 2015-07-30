using Base.Test
using Graphtypes

#simple directed graph
g = simple_graph(10)
connect!(g,1,5)
@test connected(g,1,5)
@test !connected(g,5,1)
reverse!(g,1,5)
@test !connected(g,1,5)
@test connected(g,5,1)

connect!(g,9,10)
connect!(g,9,10)
connect!(g,9,7)
connect!(g,9,4)
connect!(g,5,9)
connect!(g,9,9)

@test list_outgoing(g,9) == [4, 7, 9, 10]

connect!(g,4,5)
connect!(g,4,5)
connect!(g,5,4)

@test length(list_edges(g)) == 2 * 10

@test count_connections(g,4,5) == 2
@test total_vertices(g) == 10


#undirected structure graph
r = structure_graph(4)
connect!(r, 1, 3)
connect!(r, 2, 1)
connect!(r, 4, 1)
@test connected(r, 1, 3)
@test connected(r, 3, 1)
@test total_vertices(r) == 4
@test list_outgoing(r, 1) == [2,3,4]

@test length(list_edges(r)) == 6 
connect!(r, 2, 2)
lv = list_edges(r)
@test length(lv) == 2*4

