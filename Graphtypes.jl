module Graphtypes

export
    Graph,
    SimpleGraph,
    VertexGraph,

    simple_graph,
    vertex_graph,

    connected,
    total_edges,
    connect!,
    disconnect!,
    reverse!

abstract Graph{directed, n_m}

type SimpleGraph <: Graph
    directed::Bool
    n_m::Matrix{Bool} #adjacency matrix
end

type VertexGraph <: Graph
    directed::Bool
    n_m::Matrix{Bool}
    v_pos::Array{Float64,2}
end

function simple_graph (v_count::Int64, directed::Bool=true)
    g = SimpleGraph(directed, zeros(Bool, v_count, v_count))
    return g
end

function vertex_graph (v_pos::Array{Float64,2})
    s = size(v_pos)[1]
    g = VertexGraph (false, zeros(Bool, s, s), v_pos)Â
    return g
end

function connected(g::Graph, from::Int64, to::Int64)
    if g.directed
        return g.n_m[from, to] == 1
    else
        return g.n_m[from, to] || g.n_m[to, from] == 1
    end
end

function total_edges(g::Graph)
    return sum(g.n_m)
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
