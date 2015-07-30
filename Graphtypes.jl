module Graphtypes

export
    Graph,
    SimpleGraph,
    StructureGraph,

    simple_graph,
    structure_graph,

    connected,
    count_connections,
    list_outgoing,
    total_edges,
    total_vertices,
    list_edges,
    connect!,
    disconnect!,
    reverse!

abstract Graph{directed, vertices}

type SimpleGraph <: Graph
    vertices::Matrix{Int64} #adjacency matrix
end

type StructureGraph <: Graph
    #undirected, no duplicate edges
    vertices::Matrix{Bool}
end

function simple_graph (v_count::Int64)
    g = SimpleGraph(zeros(Int64, v_count, v_count))
    return g
end

function structure_graph (v_count::Int64)
    g = StructureGraph(zeros(Bool, v_count, v_count))
    return g
end

function list_edges(g::SimpleGraph)
    size = total_vertices(g)
    edges = Array(Int64, 0, 2)
    for i in 1:size
        for j in 1:size
            for k in 1:count_connections(g,i,j)
                edges = [edges, [i j]]
    end end end
    return edges
end

function list_edges(g::StructureGraph)
    size = total_vertices(g)
    edges = Array(Bool, 0, 2)
    for i in 1:size
        for j in i:size
            if g.vertices[i,j]
                edges = [edges, [i j]]
    end end end
    return edges
end

function list_outgoing(g::SimpleGraph, from::Int64)
    return find( x->(x != 0), g.vertices[from, :])
end

function list_outgoing(g::StructureGraph, from::Int64)
    return sort(unique([    find( x->(x != 0), g.vertices[from, :]),
                    find( x->(x != 0), g.vertices[:, from])]))
end

function connected(g::Graph, from::Int64, to::Int64)
    return g.vertices[from, to] != 0
end

function count_connections(g::Graph, from::Int64, to::Int64)
    return g.vertices[from, to]
end

function total_edges(g::SimpleGraph)
    return sum(g.vertices)
end

function total_edges(g::StructureGraph)
    return sum(g.vertices)/2
end

function total_vertices(g::Graph)
    return size(g.vertices)[2]
end

function connect!(g::SimpleGraph, from::Int64, to::Int64)
    g.vertices[from, to] += 1
end

function connect!(g::StructureGraph, from::Int64, to::Int64)
    g.vertices[from, to] = true
    g.vertices[to, from] = true
end

function disconnect!(g::SimpleGraph, from::Int64, to::Int64)
    if g.vertices[from, to] > 0
        g.vertices[from, to] -= 1
        return true
    else
        return false
    end
end

function disconnect!(g::StructureGraph, from::Int64, to::Int64)
    if g.vertices[from, to]
        g.vertices[from, to] = false
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
