module Graphtypes

export
    SimpleGraph,
    RigidityGraph,
    PebbleGraph,

    simple_graph,
    rigidity_graph,
    connected,
    connect!,
    disconnect!,
    reverse!

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

function simple_graph (v_count::Int64, directed::Bool=true)
    g = SimpleGraph(directed, zeros(Bool, v_count, v_count))
    return g
end

function rigidity_graph (n_m::Matrix{Int64}, v_pos::Array{Float64,2})
    g = RigidityGraph (false, n_m, v_pos)Â
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

end
