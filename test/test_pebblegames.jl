using Base.Test

using Pebblegames, Graphtypes

#manual pebble game moves
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

@test total_edges(p.graph) == 5

#fetching a pebble automatically
game = basic_pebble_game(5, 2, 1)

game.pebbles = [0, 2, 0, 1, 2]

connect!(game.graph, 1, 3)
connect!(game.graph, 3, 2)
connect!(game.graph, 3, 4)
connect!(game.graph, 1, 5)

@test go_get_pebbles!(game, 1, [1,2])
@test connected(game.graph, 3,1)
@test connected(game.graph, 4,3)
@test connected(game.graph, 5,1)
@test !connected(game.graph, 1,3)
@test !connected(game.graph, 3,4)
@test !connected(game.graph, 1,5)
@test game.pebbles == [2, 2, 0, 0, 1]

#fetching a pebble automatically
game = basic_pebble_game(3, 2, 1)

game.pebbles = [1, 2, 2]
connect!(game.graph, 1, 2)

go_get_pebbles!(game, 1, [1,3])

@test game.pebbles == [2, 1, 2]

#pebble game solver
m = simple_graph(3)
connect!(m, 1, 2)
connect!(m, 3, 2)
connect!(m, 3, 1)

pebbles_left, rejected_edges = solve_basic_pebble_game(m, 2, 1)

@test pebbles_left == 3 && rejected_edges == 0
@test connected(m, 1, 2) || connected(m, 2, 1)
@test connected(m, 3, 2) || connected(m, 2, 3)
@test connected(m, 1, 3) || connected(m, 3, 1)


#pebble game solver (problem as seen on http://linkage.cs.umass.edu/pg/pg.html)
g = structure_graph(6)
connect!(g, 1, 2)
connect!(g, 1, 3)
connect!(g, 2, 4)
connect!(g, 3, 4)
connect!(g, 3, 5)
connect!(g, 3, 6)
connect!(g, 4, 5)
connect!(g, 4, 6)
connect!(g, 5, 6)

pebbles_left, rejected_edges = solve_basic_pebble_game(g, 2, 1)

