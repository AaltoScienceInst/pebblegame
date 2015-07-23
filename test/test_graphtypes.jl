using Base.Test
using Graphtypes

#simple graph is directed
g = simple_graph(10)
connect!(g,1,5)
@test connected(g,1,5)
@test !connected(g,5,1)
reverse!(g,1,5)
@test !connected(g,1,5)
@test connected(g,5,1)

V = [   0.1 2.0;
        4.0 2.5;
        9.6 0.1;
        7.1 6.5]

#Vertex graphs are supposed to be not directed
r = vertex_graph(V)
connect!(r, 1, 3)
@test connected(r, 1, 3)
@test connected(r, 3, 1)




