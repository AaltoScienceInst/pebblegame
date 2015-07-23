using Base.Test

using Pebblegames, Graphtypes


p = basic_pebble_game(4, 2, 1)

@test add_edge!(p, 1, 2)
@test add_edge!(p, 2, 3)

@test connected(p.graph, 1, 2)
@test !connected(p.graph, 2, 1)
@test !connected(p.graph, 3, 2)
@test connected(p.graph, 2, 3)

@test p.pebbles == [1,1,2,2]

@test slide_move!(p, 2, 3)

@test p.pebbles == [1,2,1,2]

@test add_edge!(p, 2, 4)

@test p.pebbles == [1,1,1,2]

@test slide_move!(p, 1, 2)

@test p.pebbles == [2,0,1,2]
@test connected(p.graph, 2, 1)
@test connected(p.graph, 2, 4)
@test connected(p.graph, 3, 2)

@test add_edge!(p, 1, 4)
@test slide_move!(p, 2, 1)
@test slide_move!(p, 3, 2)
@test add_edge!(p, 3, 4)

@test p.pebbles == [0,0,1,2]
@test connected(p.graph, 1, 2)
@test connected(p.graph, 2, 3)
@test connected(p.graph, 3, 4)
@test connected(p.graph, 2, 4)

@test total_edges(p) == 5
