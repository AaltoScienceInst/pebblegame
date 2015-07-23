module Pebblegames

using Graphtypes

export
    basic_pebble_game,
    add_edge!,
    slide_move!

type PebbleGame
    graph::Graph
    pebbles::Array{Int64,1}
    l::Int64
end

function basic_pebble_game (s::Int64, k::Int64, l::Int64)
    g = simple_graph(s, true)
    p = PebbleGame(g, k*ones(s), l)
    return p
end

function add_edge!(p::PebbleGame, i::Int64, j::Int64)
    if p.pebbles[i] != 2 || p.pebbles[j] != 2
        return false
    end
    if connected(p.graph,i,j) || connected(p.graph,j,i)
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
    reverse!(p.graph,i,j)
    p.pebbles[j]-=1
    p.pebbles[i]+=1
    return true
end
end
