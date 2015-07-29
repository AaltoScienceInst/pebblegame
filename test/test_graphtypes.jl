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

@test count_connections(g,4,5) == 2
@test total_vertices(g) == 10


V = [   0.1 2.0;
        4.0 2.5;
        9.6 0.1;
        7.1 6.5]

#undirected vertex graph
r = vertex_graph(V,false)
connect!(r, 1, 3)
@test connected(r, 1, 3)
@test connected(r, 3, 1)
@test total_vertices(r) == 4



