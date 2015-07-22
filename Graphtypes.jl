module Graphtypes

export
    simple_graph,
    rigidity_graph,
    pebble_graph,
    connected,
    connect!,
    disconnect!,
    reverse!,
    p_add_edge!,
    p_slide_move!

abstract Graph{directed, n_m}

type SimpleGraph <: Graph
    directed::Bool
    n_m::Matrix{Bool} #adjacency matrix
end

type RigidityGraph <: Graph
    directed::Bool
    n_m::Matrix{Bool}
    v_pos::Array{Float64,2}
end

type PebbleGraph <: Graph
    directed::Bool
    n_m::Matrix{Bool}
    pebbles::Array{Int64,1}
end

function simple_graph (v_count::Int64)
    g = SimpleGraph(true, zeros(Bool, v_count, v_count))
    return g
end

function rigidity_graph (n_m::Matrix{Int64}, v_pos::Array{Float64,2})
    g = RigidityGraph (false, n_m, v_pos)Â
    return g
end

function pebble_graph (size::Int64)
    g = PebbleGraph (true, zeros(size, size), 2*ones(size))
    return g
end


function connected(g::Graph, from::Int64, to::Int64)
    if g.directed
        return g.n_m[from, to] == 1
    else
        return g.n_m[from, to] || g.n_m[to, from] == 1
    end
end

function connect!(g::Graph, from::Int64, to::Int64)
    g.n_m[from, to] = 1
end

function disconnect!(g::Graph, from::Int64, to::Int64)
    g.n_m[from, to] = 0
end

function reverse!(g::Graph, i1::Int64, i2::Int64)
    g.n_m[i1, i2], g.n_m[i2, i1] = g.n_m[i2, i1], g.n_m[i1, i2]
end 


function p_add_edge!(g::PebbleGraph, i::Int64, j::Int64)
    if g.pebbles[i] != 2 || g.pebbles[j] != 2
        return
    end
    if connected(g,i,j) || connected(g,j,i)
        return
    end
    g.pebbles[i] -= 1
    connect!(g,i,j)
end

function p_slide_move!(g::PebbleGraph, i::Int64, j::Int64)
    if !connected(g,i,j)
        return
    end
    if g.pebbles[j]<1
        return
    end
    reverse!(g,i,j)
    g.pebbles[j]-=1
    g.pebbles[i]+=1
end

end
