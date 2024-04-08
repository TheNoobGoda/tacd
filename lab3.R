library(igraph)


#1
gU = make_graph(c('a','d',
                  'a','f',
                  'b','f',
                  'c','b',
                  'e','f',
                  'f','c',
                  'f','d'),
                directed = F)
class(gU)

plot(gU)

V(gU)
E(gU)

gU[]

degree(gU)
closeness(gU)
betweenness(gU)

#2

gD = make_graph(c('a','d',
                  'a','f',
                  'b','f',
                  'c','b',
                  'e','f',
                  'f','c',
                  'f','d'),
                directed = T)

plot(gD)

V(gD)
E(gD)

gD[]

degree(gD)
closeness(gD)
betweenness(gD)


l = layout_in_circle(gD)
plot(gD,layout = l)

l = layout_as_star(gD)
plot(gD,layout = l)

l = layout_as_tree(gD)
plot(gD,layout = l)

plot(gD,layout=layout_nicely(gD))
