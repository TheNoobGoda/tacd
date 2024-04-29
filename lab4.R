library(tm)
library(text2vec)


#1
docs = c("Mining is important for finding gold",
         "Classification and regression are data mining",
         "Data mining deals with data")

vc = VectorSource(docs)
corpus = Corpus(vc)

dtm = DocumentTermMatrix(corpus)
dtm

#a
nDocs(dtm)
nTerms(dtm)
Terms(dtm)

#b
inspect(dtm)
as.matrix(dtm)

#save the dtm based on term-frequency
dtm_tf = dtm
#or
dtm_tf = weightTf(dtm)

inspect(dtm_tf)
as.matrix(dtm_tf)

#c
dtm_bin = weightBin(dtm)
inspect(dtm_bin)
as.matrix(dtm_bin)

#d
dtm_tfidf = weightTfIdf(dtm)
inspect(dtm_tfIif)
as.matrix(dtm_tfidf)

#e
#mining appears in all documents so it doesn't have any discriminating power

#f
sim2(as.matrix(dtm_tf),method = 'cosine')
sim2(as.matrix(dtm_bin),method = 'cosine')
sim2(as.matrix(dtm_tfidf),method = 'cosine')


#2

cq = Corpus(VectorSource("data mining"))
dtmq = DocumentTermMatrix(cq)

mq =matrix(0,ncol=nTerms(dtm_tf),dimnames = list('q', Terms(dtm_tf)))
mq[1,Terms(dtmq)] = 1
mq
#a
sim2(as.matrix(dtm_bin),mq,method = 'cosine')
#b
sim2(as.matrix(dtm_tf),mq,method = 'cosine')
#c
sim2(as.matrix(dtm_tfidf),mq,method = 'cosine')
