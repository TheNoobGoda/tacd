library(arules)
library(arulesViz)

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
