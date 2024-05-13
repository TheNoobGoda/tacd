library(tm)
library(text2vec)
library(wordcloud)


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



###################################4.2###########################

#3
#a
reut21578 = system.file("texts", "crude", package = "tm")
reuters = VCorpus(DirSource(reut21578), readerControl = list(reader = readReut21578XMLasPlain))

data("crude")
reuters
r0 = reuters 

#b
inspect(reuters[[1]])
meta(reuters[[1]])

#c
wordcloud(reuters,colors = rainbow(20))

#d
reuters = tm_map(reuters,stripWhitespace)
reuters = tm_map(reuters,content_transformer(tolower))
reuters = tm_map(reuters,removeWords,stopwords("english"))
reuters = tm_map(reuters,stemDocument)
reuters = tm_map(reuters,removePunctuation)

#e
wordcloud(reuters,colors = rainbow(20))

#f
dtm = DocumentTermMatrix(reuters)
inspect(dtm[5:10,740:743])

#g
findFreqTerms(dtm,lowfreq = 10)

#h
findAssocs(dtm,c("opec"),c(0.8))

