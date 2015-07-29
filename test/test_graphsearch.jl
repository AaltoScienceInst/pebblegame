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

#successful search with an unambiguous path
@test depth_first_search(g, 1, 7, (g,x)->(x==7)) == [1, 2, 5, 7]
#allow matching before moving only if start not in blocklist
@test depth_first_search(g, 1, 7, (g,x)->(x<3), [1]) == [1,2]
@test depth_first_search(g, 1, 7, (g,x)->(x<3)) == [1]

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

# 1   2   3   4   5
# o - x - o - o - o 0
# |   |   |   |   |
# o - x - o - x - o 5
# |   |   |   |   |
# o - o - o - x - o 10
# |   |   |   |   |
# x - x - x - o - o 15
# |   |   |   |   |
# o - o - o - o - o 20

g = simple_graph(25,false)
for i=(0:4)*5
    for j=1:5
        if (j%5)!=0
            connect!(g, i+j, i+j+1);
        end
        if i!=20
            connect!(g, i+j, i+j+5);
        end
end end

blocks = [2, 7, 9, 14, 16, 17, 18]

@test length(depth_first_search(g, 1, 5, (g,x)->(x==21))) == 5
@test length(depth_first_search(g, 21, 5, (g,x)->(x==1))) == 5
#successful search
@test length(depth_first_search(g, 23, 14, (g,x)->(x==1),blocks)) == 15
@test 9 <= length(depth_first_search(g, 1, 25, (g,x)->(x==25))) <= 25
#failed search
@test length(depth_first_search(g, 1, 25, (g,x)->(x==25),[17,18,19,20,22])) ==0
