# mushrooms.r

install.packages('rpart')
install.packages('rattle')

library(rpart)
library(rattle)

# read in mushroom data

mushrooms <- read.table ("http://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data", header=FALSE, sep=',')

str(mushrooms)
head(mushrooms)

attributes = c('EorP', 'CapShape','CapSurf','CapColor','Bruises','Odor','GillAtt','GillSpace','GillSize',
             'GillColor','StalkShape','StalkRoot','SsurfAbove','SsurfBelow',
             'ScolorAbove','ScolorBelow','VeilType','VeilColor','RingNum','RingType','Spore','Population','Habitat')

colnames(mushrooms) <- attributes

head(mushrooms)

# Build the model
M <- ncol(mushrooms)
input  <- names(mushrooms)[2:M]  					# names of input variables
target <- "EorP"								# name of target variable				

N <- nrow(mushrooms)  									# 8124 observations

train <- sample(N, 0.7*N)  							# 5686 observations

# The elements of setdiff(x,y) are those elements in x but not in y
test <-  setdiff(seq_len(N),train)      # 2438 observations not in train


M <- ncol(mushrooms)
input  <- names(mushrooms)[2:M]  					# names of input variables
target <- "EorP"								# name of target variable							
form <- formula(EorP ~ .)						# Describe the model to R

tree.m <- rpart(form,
                 data=mushrooms[train, c(input,target)],
                 method="class",
                 parms=list(split="information"),
                 control=rpart.control(usesurrogate=2, 
                                       maxsurrogate=0,
                                       minsplit=30,
                                       maxdepth=20))
drawTreeNodes(tree.m)






