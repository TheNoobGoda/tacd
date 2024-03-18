library(recommenderlab)
library(readr)
library(arules)

#6
df = read.csv('~/Desktop/tacd/log1.csv')
df
#read transforming to factors
df = read_csv('~/Desktop/tacd/log1.csv', col_types = list(col_factor(),col_factor()))
df

brm = as(as.data.frame(df),"binaryRatingMatrix")

getData.frame(brm)

brm_offline = brm[1:6,]
getData.frame(brm_offline)
getRatingMatrix(brm_offline)
inspect(getRatingMatrix(brm_offline))

rowCounts(brm_offline)
colCounts(brm_offline)

image(brm_offline)

modelAR = Recommender(brm_offline,'AR')
getModel(modelAR)
