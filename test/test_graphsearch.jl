using Base.Test

using Graphtypes, Graphsearch

g = simple_graph(7)

connect!(g, 1, 2)
connect!(g, 2, 3)
connect!(g, 2, 1)
connect!(g, 1, 3)
connect!(g, 5, 2)
connect!(g, 2, 5)
connect!(g, 5, 7)

@test depth_first_search(g, 1, 7, (g,x)->(x==7)) == [1,2,5,7]


g = simple_graph(9)

connect!(g, 1, 2)
connect!(g, 2, 1)
connect!(g, 2, 3)
connect!(g, 3, 2)
connect!(g, 1, 4)
connect!(g, 4, 1)
connect!(g, 2, 4)
connect!(g, 4, 2)
connect!(g, 3, 5)
connect!(g, 5, 8)
connect!(g, 8, 9)
connect!(g, 7, 4)
connect!(g, 6, 7)
connect!(g, 7, 9)
connect!(g, 7, 8)
connect!(g, 5, 4)

#successful search
@test length(depth_first_search(g, 1, 9, (g,x)->(x==8))) >= 4
#failed search
@test length(depth_first_search(g, 4, 9, (g,x)->(x==6))) == 0
