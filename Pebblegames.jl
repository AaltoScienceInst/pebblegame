module Pebblegames

using Graphtypes

export
    basic_pebble_game,
    add_edge!,
    slide_move!


function basic_pebble_game (size::Int64)
    g = PebbleGraph (true, zeros(size, size), 2*ones(size))
    return g
end

function add_edge!(g::PebbleGraph, i::Int64, j::Int64)
    if g.pebbles[i] != 2 || g.pebbles[j] != 2
        return false
    end
    if connected(g,i,j) || connected(g,j,i)
        return false
    end
    g.pebbles[i] -= 1
    connect!(g,i,j)
    return true
end

function slide_move!(g::PebbleGraph, i::Int64, j::Int64)
    if !connected(g,i,j)
        return false
    end
    if g.pebbles[j]<1
        return false
    end
    reverse!(g,i,j)
    g.pebbles[j]-=1
    g.pebbles[i]+=1
    return true
end

end
