module Pebblegames

using Graphtypes
using Graphsearch

export
    solve_basic_pebble_game,
    basic_pebble_game,
    add_edge!,
    slide_move!,
    go_get_pebbles!

type PebbleGame
    graph::Graph
    pebbles::Array{Int64,1}
    k::Int64
    l::Int64
end

#=
    BASIC (k, l) PEBBLE GAME
    from Pebble Game Algorithms and Sparse Graphs - Lee & Streinu
    http://arxiv.org/pdf/math/0702129.pdf
    
    Rules:
        - vertex can hold up to k pebbles
        - new edge is accepteble if at least l+1 pebbles at endpoints
    Moves:
        - slide move: if there's at a connection i,j and at least one
            pebble on j, reverse i,j and move a pebble from j to i
        - add edge move: add an acceptable edge i,j and remove a
        pebble from i
=#
function solve_basic_pebble_game(graph::Graph, k::Int64, l::Int64)

    vt= total_vertices(graph)
    et = total_edges(graph)
    
    game = basic_pebble_game(vt, k, l)
    edges = list_edges(graph)
    rejected_count = 0
    for n=1:et
        i = edges[n,1]
        j = edges[n,2]

        if add_edge!(game, i, j)
            #successfully added an edge, move on
            continue
        else
            if game.pebbles[i] + game.pebbles[j] < game.l+1
                go_get_pebbles!(game, i, [i, j])
                go_get_pebbles!(game, j, [i, j])
            end
            if game.pebbles[i] + game.pebbles[j] < game.l+1
                rejected_count += 1
                continue
            end
            
            add_edge!(game, i, j)
    end end
    return sum(game.pebbles), rejected_count
end

function basic_pebble_game (s::Int64, k::Int64, l::Int64)
    g = simple_graph(s)
    p = PebbleGame(g, k*ones(s), k ,l)
    return p
end

function add_edge!(p::PebbleGame, i::Int64, j::Int64)
    if p.pebbles[i] + p.pebbles[j] < p.l+1
        return false
    end
    p.pebbles[i] -= 1
    connect!(p.graph,i,j)
    return true
end

function slide_move!(p::PebbleGame, i::Int64, j::Int64)
    if !connected(p.graph,i,j)
        return false
    end
    if p.pebbles[j]<1
        return false
    end
    if p.pebbles[i]>=p.k
        return false
    end
    reverse!(p.graph,i,j)
    p.pebbles[j]-=1
    p.pebbles[i]+=1
    return true
end

function go_get_pebbles!(game::PebbleGame, node::Int64,
                            blacklist::Array{Int64,1})
    graph = game.graph
    pebbles = game.pebbles
    #helper function that looks for available pebbles and moves them to node
    for i=1:(min(game.l+1,game.k) - pebbles[node]) #find missing pebbles for i
        path = depth_first_search(graph, node, total_vertices(graph), 
                                (g,x)->(pebbles[x]>0), blacklist)
        
        path = reverse(path)
        #go fetch that pebble
        for pair in zip(path,path[2:end])
            x,y = pair
            slide_move!(game,y,x)
end end end


end
