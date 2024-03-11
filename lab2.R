library('arules')
library('dplyr')
library('readr')

df = read.csv('/home/goda/Desktop/tacd/log.csv')

summary(df)
df

#1

top_pages = df %>% group_by(PAGE) %>% count() %>% arrange(desc(n))
top_pages

top_pages = df %>% group_by(PAGE) %>% tally(sort = TRUE) %>% top_n(3) %>% pull(PAGE)
top_pages


#2
# table(df)

matrix = table(df$USER,df$PAGE)
matrix

dis = dist(matrix)
dis

c1 = hclust(dis)
c1

plot(c1)
plot(c1,hang = -0.1)

c2 = cutree(c1,k=2)
c2

rect.hclust(c1,k=2)


#3
dcluster = mutate(df,Cluster = c2[df$USER])
dcluster

filter(dcluster, Cluster == 1) %>% pull(PAGE)
top_c1 =  filter(dcluster, Cluster == 1) %>% group_by(PAGE) %>% tally(sort = TRUE)
top_c1

top_2_c1 = filter(dcluster, Cluster == 1) %>% group_by(PAGE) %>% tally(sort = TRUE) %>% top_n(2) %>% pull(PAGE)
top_2_c1

#4
top_2_c2 = filter(dcluster, Cluster == 2) %>% group_by(PAGE) %>% tally(sort = TRUE) %>% top_n(2) %>% pull(PAGE)
top_2_c2

#5
c_u2 = dcluster %>% filter(USER == 'u2') %>% select(Cluster) %>% head(1) %>% pull
c_u2

top_u2 = filter(dcluster, Cluster == c_u2) %>% group_by(PAGE) %>% tally(sort = TRUE) %>% top_n(3) %>% pull(PAGE) #select(PAGE)
top_u2

u2_p = filter(dcluster, USER == 'u2') %>% pull(PAGE)
u2_p

top_u2[! top_c1_p %in% u2_p]



