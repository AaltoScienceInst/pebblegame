using Base.Test
using Graphtypes

g = simple_graph(10)
connect!(g,1,5)

@test connected(g,1,5)
@test !connected(g,5,1)

reverse!(g,1,5)

@test !connected(g,1,5)
@test connected(g,5,1)

N = [   0 0 1 1;
        0 0 1 0;
        0 1 0 1;
        1 0 1 0]


V = [   0.1 2.0;
        4.0 2.5;
        9.6 0.1;
        7.1 6.5]


r = rigidity_graph(N, V)
connected(r,2,2)
p = pebble_graph(4)
connected(p,2,2)
@test connected(r, 1, 3)
@test connected(r, 3, 1)


p_add_edge!(p,1,2)
@test p.pebbles == [1,2,2,2]
