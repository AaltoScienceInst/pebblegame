module Pebblegames

using Graphtypes

export
    basic_pebble_game,
    add_edge!,
    slide_move!

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

function basic_pebble_game (s::Int64, k::Int64, l::Int64)
    g = simple_graph(s, true)
    p = PebbleGame(g, k*ones(s), k ,l)
    return p
end

function add_edge!(p::PebbleGame, i::Int64, j::Int64)
    if p.pebbles[i] < p.l+1 || p.pebbles[j] < p.l+1
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
end
