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
df2 = read_csv('~/Desktop/tacd/log1Ratings.csv', col_types = list(col_factor(),col_factor(),col_integer()))
rrm = as(as.data.frame(df2),"realRatingMatrix")
getRatingMatrix(rrm)
image(rrm)

getData.frame(rrm)

rrm_offline = rrm[1:6,]
rrm_test = rrm[7:8,]

modelUBCF2 = Recommender(rrm_offline, "UBCF",parameter=list(method="cosine",nn=2))
getModel(modelUBCF2)
pred = predict(modelUBCF2,rrm_test,type='ratings')
getList(pred)

modeliBCF2 = Recommender(rrm_offline, "iBCF",parameter=list(method="cosine",k=2))
getModel(modeliBCF2)
pred = predict(modeliBCF2,rrm_test,type='ratings')
getList(pred)


similarity(rrm_offline,method = 'cosine')
similarity(rrm_offline,method = 'cosine', which = 'items')


############################ 2.4

log = read_csv('~/Desktop/tacd/log1.csv', col_types = list(col_factor(),col_factor()))
brm = as(as.data.frame(log),'binaryRatingMatrix')
brm = brm[rowCounts(brm)>=2]

set.seed(2021)
e = evaluationScheme(brm, method='split', train=0.8, given=2)

e


inspect(getRatingMatrix(getData(e,'train')))
inspect(getRatingMatrix(getData(e,'known')))
inspect(getRatingMatrix(getData(e,'unknown')))


methods <- list(
  "popular" = list(name="POPULAR", param = NULL), 
  "user-based CF" = list(name="UBCF", param = NULL), 
  "item-based CF" =list(name="IBCF", param = NULL)
  )

results = evaluate(e,methods, type='topNList', n=c(1,3,5))
class(results)
avg(results)
names(results)
results[['popular']]


getConfusionMatrix(results[['popular']])

model1 = Recommender(getData(e,'train'),'POPULAR')
preds1 = predict(model1, getData(e,'known'), n=3)
getList(preds1)

model2 = Recommender(getData(e,'train'),'UBCF')
preds2 = predict(model2, getData(e,'known'), n=3)
getList(preds2)

model3 = Recommender(getData(e,'train'),'IBCF')
preds3 = predict(model3, getData(e,'known'), n=3)
getList(preds3)


plot(results, annotate=TRUE)


plot(results, "prec/rec", annotate=TRUE)
