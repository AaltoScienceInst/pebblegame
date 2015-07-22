using Base.Test
using Pebblegames

#simple graph is directed
p = basic_pebble_game(4)

add_edge!(p, 1, 2)
add_edge!(p, 1, 3)
