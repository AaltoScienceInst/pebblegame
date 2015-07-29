module Graphsearch

using Graphtypes

export
    depth_first_search

function depth_first_search(g::Graph, starting_point::Int64, max_depth::Int64,
    f::Function, blacklist::Array{Int64,1}=Array((Int64),0))
    
    path = [starting_point]
    visited = [starting_point, blacklist]
    
    while length(path) != 0
        current = path[end]
        neighbours = list_outgoing(g, current)

        if f(g, current)

            #ignore match if it's a blacklisted starting point
            if !((current == starting_point) && (starting_point in blacklist))
                #expected condition is met
                return path
        end end
        
        #find next place to be
        next_index = findfirst(
                    n->(!(n in visited)),list_outgoing(g, current))

        if next_index != 0
            #move forward
            push!(path, neighbours[next_index])
            push!(visited, neighbours[next_index])
        else
            #move backward
            pop!(path)
        end
    end

    #search failed
    return []
end

end
