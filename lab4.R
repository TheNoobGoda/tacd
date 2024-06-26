library(tm)
library(text2vec)
library(wordcloud)
library(dplyr)
library(tidyr)
library(ggplot2)
library(e1071)
library(performanceEstimation)


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
inspect(dtm_tfidf)
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


############################################4.4############################

#a
data(acq)
inspect(head(acq))

#b
cleanup = function(docs,spec_words=NULL){
  docs = tm_map(docs,content_transformer(tolower))
  docs = tm_map(docs,removeNumbers)
  docs = tm_map(docs,removeWords,stopwords("english"))
  docs = tm_map(docs,removeWords, spec_words)
  docs = tm_map(docs,removePunctuation)
  docs = tm_map(docs,stripWhitespace)
  docs = tm_map(docs,stemDocument)
  docs
}

par(mfrow=c(1,2))
wordcloud(acq)

acq1 = cleanup(acq,c("said","the","and"))
wordcloud(acq1)
par(mfrow=c(1,1))

#c
dtm = DocumentTermMatrix(acq1)
dtm

#d
mdf = as_tibble(as.matrix((dtm)))

mdf_freq = mdf %>% 
  select(findFreqTerms(dtm,nDocs(dtm)/2)) %>%
  summarise_all(sum) %>%
  gather() %>%
  arrange(desc(value))

mdf_freq$key = factor(mdf_freq$key, levels = mdf_freq$key[order(mdf_freq$value)])

#e
dists = dist(as.matrix((dtm)))
Tree = hclust(dists)
plot(Tree)

#f


#g
h = hclust(dists,method = "ward.D")
plot(h)

#h
Clusters = cutree(h,3)
Clusters
rect.hclust(h,3)

#i
c1 = dtm[Clusters == 1]
c2 = dtm[Clusters == 2]
c3 = dtm[Clusters == 3]

plot.wordcloud = function(dtmc) {
  mdf_c = as_tibble(as.matrix(dtmc)) %>%
    summarise_all(sum) %>%
    gather() %>%
    arrange(desc(value))
    wordcloud(mdf_c$key,mdf_C$value,min.freq = 5)
}

plot.wordcloud(c1)


###############################################4.5############################

#a
data("crude")
data("acq")
docs = c(acq[0:50],crude[1:20])

cleanup = function(docs,spec_words=NULL){
  docs = tm_map(docs,content_transformer(tolower))
  docs = tm_map(docs,removeNumbers)
  docs = tm_map(docs,removeWords,stopwords("english"))
  docs = tm_map(docs,removeWords, spec_words)
  docs = tm_map(docs,removePunctuation)
  docs = tm_map(docs,stripWhitespace)
  docs = tm_map(docs,stemDocument)
  docs
}

docs = cleanup(docs,c("said","reuters","reuter"))

#b
dtm = DocumentTermMatrix(docs)

#c
dtm = removeSparseTerms(dtm,0.8)

#d
dat = cbind(data.frame(as.matrix(dtm),class = as.factor(c(rep("acq",50),rep("crude",20)))))
dat

#e
exp = performanceEstimation(PredTask(class ~.,dat),
                            c(Workflow(learner = "naiveBayes"),
                                       workflowVariants(learner="svm",
                                               learner.pars=
                                                 list(kernel=c("linear","radial")))),
                            EstimationTask(metrics = "err",method = CV())
                            )

#f
summary(exp)

plot(exp)




