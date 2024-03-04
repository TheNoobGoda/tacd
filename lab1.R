library(arules)
library(arulesViz)
library(tidyverse)

data("Groceries", package = "arules")
Groceries
summary(Groceries)
size(Groceries)
inspect(Groceries[1:5])
unique(Groceries)
length(which(duplicated(Groceries)))
itemFrequency(Groceries)

itemFrequencyPlot(Groceries, topN = 5)
itemFrequencyPlot(Groceries, support= 0.1)

fsets = apriori(Groceries,parameter=list(support=0.01,target="frequent itemsets"))
fsets
class(fsets)
inspect(fsets)
sortedSets = sort(fsets,by="support",decreasing=TRUE)
inspect(sortedSets[1:5])

summary(fsets)
length(fsets)
nitems(fsets)
labels(fsets)
itemInfo(fsets)

csets=fsets[is.closed(fsets)]
csets
inspect(csets)

msets=fsets[is.maximal(fsets)]
msets
inspect(msets)


rules = apriori(Groceries,parameter=list(support=0.01,target="rules",conf=0.5))
class(rules)
inspect(rules)
plot(rules,method = 'grouped matrix')

rules = apriori(Groceries,parameter=list(support=0.01,target="rules",conf=0.25))
summary(rules)
quality(rules)
plot(rules)
inspect(rules)

subrules = subset(rules,subset = lift > 2)
inspect(subrules)

prules = subset(rules,subset = (lift > 2 & (rhs %in% "whole milk" | rhs %in% "yogurt")))
inspect(prules)

df = read.csv("/home/goda/Desktop/tacd/german_credit.csv")
summary(df)
df <- df[-c(1)]
df <- df %>% mutate_if(is.character, as.factor)
df <- discretizeDF(df,methods = list(
  duration_in_month=list(method="interval",4,labels=c("short","med-short","med-long","long")),
  credit_amount=list(method="interval",4,labels=c("small","med-small","med-high","high")),
  age=list(method="interval",4,labels=c("young adult","adult","senior","golden"))
),
default = list(method = "interval"))
summary(df)

dft = as(df, "transactions")
itemInfo(dft)

rules = apriori(dft)
plot(rules)
rules = apriori(df,parameter = list(confidence =1))
plot(rules)
inspect(rules[1:5])

item_dft = itemInfo(dft)
myItems <- subset(item_dft,variables %in% c("age","personal_status_sex","job","housing","purpose"))$labels
rules = apriori(df,parameter = list(confidence = 0.6, minlen = 2), appearance = list(both = myItems,default = "none"))
plot(rules)


                