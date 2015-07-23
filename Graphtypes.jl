module Graphtypes

export
    Graph,
    SimpleGraph,
    VertexGraph,

    simple_graph,
    vertex_graph,

    connected,
    count_connections,
    list_incoming,
    list_outgoing,
    total_edges,
    connect!,
    disconnect!,
    reverse!

abstract Graph{directed, vertices}

type SimpleGraph <: Graph
    directed::Bool
    vertices::Matrix{Float64} #adjacency matrix
end

type VertexGraph <: Graph
    directed::Bool
    vertices::Matrix{Float64}
    v_pos::Array{Float64,2}
end

function simple_graph (v_count::Int64, directed::Bool=true)
    g = SimpleGraph(directed, zeros(Bool, v_count, v_count))
    return g
end

function vertex_graph (v_pos::Array{Float64,2}, directed::Bool=true)
    s = size(v_pos)[1]
    g = VertexGraph (directed, zeros(Bool, s, s), v_pos)Â
    return g
end

function list_incoming(g::Graph, to::Int64)
    return find( x->(x != 0), g.vertices[:, to])
end

function list_outgoing(g::Graph, from::Int64)
    return find( x->(x != 0), g.vertices[from, :])
end

function connected(g::Graph, from::Int64, to::Int64)
    if g.directed
        return g.vertices[from, to] != 0
    else
        return g.vertices[from, to] !=0 || g.vertices[to, from] != 0
    end
end

function count_connections(g::Graph, from::Int64, to::Int64)
    if g.directed
        return g.vertices[from, to]
    else
        return g.vertices[from, to] + g.vertices[to, from]
    end
end

function total_edges(g::Graph)
    return sum(g.vertices)
end

function connect!(g::Graph, from::Int64, to::Int64)
    g.vertices[from, to] += 1
end

function disconnect!(g::Graph, from::Int64, to::Int64)
    if g.vertices[from, to] > 0
        g.vertices[from, to] -= 1
        return true
    else
        return false
    end
end

function reverse!(g::Graph, i1::Int64, i2::Int64)
    if disconnect!(g,i1,i2)
        connect!(g,i2,i1)
        return true
    end
    return false
end 

end
