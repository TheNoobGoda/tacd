library(igraph)

# slide 24: strong and weak components
# a verbose way
g <- graph.empty(directed=TRUE)
g <- g+vertices('A','B','C','D','E','F','G','H')
g <- g+edges('B','A') #B links to A
g <- g+edges('B','E')
g <- g+edges('B','C')
g <- g+edges('C','D')
g <- g+edges('D','B')
g <- g+edges('D','C')
g <- g+edges('E','D')
g <- g+edges('F','H')
g <- g+edges('H','G')
g <- g+edges('B','A')
g <- g+edges('G','H')
plot(g)

# connected components
wcc <- components(g,mode='weak')
scc <- components(g,mode='strong')
wcc
scc

# colors for plotting
colors <- rainbow(10)
V(g)$color <- colors[scc$membership]
V(g)

# vertex size for visualization
V(g)$size <- 30

# each connected component has a different color
plot(g)

# shortest path
# vertices and edges
sp <- shortest_paths(g, from='D', to='A', output= 'both') # from D to A: D -> B -> A
sp

# colors
# vertices: white, edges: gray
V(g)$color <-  'white'
E(g)$color <-  'gray'
plot(g)

# highlight shortest path
V(g)[sp$vpath[[1]]]$color <- 'red'
E(g)[sp$epath[[1]]]$color <- 'red'
V(g)$size  <-  40
plot(g)

# pairwise shortest path lengths
distances(g) # wrong!!
distances(g, mode='out') # to follow link directions

# graph diameter
d <-diameter(g, directed=TRUE, unconnected = TRUE, weights = NULL)
d

# clique: set of nodes that are fully connected
n_clique <- clique_num(g)
n_clique

# maximal clique
l_clique <- largest_cliques(g)
l_clique

# cliques by size
k3 <- cliques(g,min=3,max=5)
k3


colors=rainbow(3)
E(g)$color <- 'gray'

for (i in 1:length(k3)){
  V(g)$color <-'white'
  V(g)[k3[[i]]]$color <- colors[i]
  plot(g)
  readline()  #plot the other clique
}

# -------------- Standard network metrics -------------------------
#degree centrality
degree(g,V(g),mode='total')
degree(g,V(g),mode='in')
degree(g,V(g),mode='out')

# other centrality measures
betweenness(g,V(g),directed = TRUE)
closeness(g,V(g), mode='total')

#eigenvector pageRank
evcent(g,scale=TRUE)$vector

page_rank(g,vids = V(g), directed = TRUE, damping = .85)$vector