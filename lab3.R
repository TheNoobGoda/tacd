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


hs = hub_score(gD)
sort(hs$vector, decreasing = T)


as = authority_score(gD)
sort(as$vector, decreasing = T)


pr = page_rank(gD,damping = 0.9)
sort(pr$vector, decreasing = T)



##############################3.2##########################

#3
#a
karate = make_graph("Zachary")
plot(karate)


#b
ceb = cluster_edge_betweenness(karate)
ceb


#c
plot(ceb,karate)

#d
sizes(ceb)
membership(ceb)

#e
plot(as.hclust(ceb))

#f
cfg = cluster_fast_greedy(karate)
cfg

#g
plot(cfg,karate)
plot(cfg,karate,layout = layout_as_star(karate))
sizes(cfg)
membership(cfg)
hc = as.hclust(cfg)
plot(hc)
rect.hclust(hc,3)

#4
par(mfrow = c(1,2))

gU = make_graph(c('a','d',
                  'a','f',
                  'b','f',
                  'c','b',
                  'e','f',
                  'f','c',
                  'f','d'),
                directed = F)

ceb = cluster_edge_betweenness(gU)
cfg = cluster_fast_greedy(gU)

plot(ceb,gU,main="EB")
plot(cfg,gU, main="FG")

sizes(ceb)
membership(ceb)
sizes(cfg)
membership(cfg)

hceb = as.hclust(ceb)
plot(hceb)
rect.hclust(hceb,3)

hcfg = as.hclust(cfg)
plot(hcfg)
rect.hclust(hcfg,2)



