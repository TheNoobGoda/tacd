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
rules = getModel(modelAR)$rule_base
inspect(rules)


#7
brm_u7 = brm[7,]
getData.frame(brm_u7)
pred = predict(modelAR,brm_u7,n=2)

getList(pred)

r_u7 = subset(rules, lhs %in% c('C','F'))
inspect(r_u7)


#8
brm_u8 = brm[8,]
getData.frame(brm_u8)
pred = predict(modelAR,brm_u8)

getList(pred)

r_u8 = subset(rules, lhs %in% c('C'))
inspect(r_u8)


#9
recommenderRegistry$get_entries(dataType ="binaryRatingMatrix")


#10
model_pop = Recommender(brm_offline,"POPULAR")
getModel(model_pop)
brm_test = brm[7:8,]
getData.frame(brm_test)
pred = predict(model_pop,brm_test, n=2)
getList(pred)



####################### 2.3

#11
s_cos_user = similarity(brm_offline,method = "cosine",which = "users")
s_cos_user
s_cos_item = similarity(brm_offline,method = "cosine",which = "items")
s_cos_item


#12
modelUBCF = Recommender(brm_offline, "UBCF",parameter=list(method="cosine",nn=3))
getModel(modelUBCF)
pred = predict(modelUBCF,brm_test,n=2)
getList(pred)

modeliBCF = Recommender(brm_offline, "iBCF",parameter=list(method="cosine",k=3))
getModel(modeliBCF)
pred = predict(modeliBCF,brm_test,n=2)
getList(pred)


#13
recommenderRegistry$get_entries(dataType ="realRatingMatrix")


#14
df2 = read.csv('~/Desktop/tacd/log1Ratings.csv')
brm2 = as(as.data.frame(df2),"nonBinaryRatingMatrix")

getData.frame(brm2)

brm2_offline = brm2[1:6,]


