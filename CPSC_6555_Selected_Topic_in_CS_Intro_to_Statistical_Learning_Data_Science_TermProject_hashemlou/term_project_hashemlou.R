library(ISLR)
set.seed(1)
train <- sample(1:nrow(OJ), 800)
OJ.train <- OJ[train, ]
OJ.test <- OJ[-train, ]
library(tree)
OJ.t1 <- tree(Purchase ~ ., data = OJ.train)
summary(OJ.t1)
OJ.t1
plot(OJ.t1)
text(OJ.t1, pretty = 0)
OJ.pred <- predict(OJ.t1, newdata = OJ.test, type = "class")
table(prediction = OJ.pred, truth = OJ.test$Purchase)
mean( OJ.pred == OJ.test$Purchase )
# test error rate:
mean( OJ.pred != OJ.test$Purchase )
OJ.cv <- cv.tree(OJ.t1, FUN = prune.misclass)
plot(OJ.cv$size, OJ.cv$dev, type = "b", xlab = "tree size", ylab = "cross-validated classification error rate")
OJ.cv
OJ.prune <- prune.misclass(OJ.t1, best = 7)
plot(OJ.prune)
text(OJ.prune, pretty = 0)
summary(OJ.t1)
summary(OJ.prune)
OJ.prune.pred <- predict(OJ.prune, newdata = OJ.test, type = "class")
table(OJ.prune.pred, OJ.test$Purchase)
mean( OJ.prune.pred == OJ.test$Purchase )
mean( OJ.prune.pred != OJ.test$Purchase )
library(randomForest)
#preparing data
OJ$Purchase <- ifelse(OJ$Purchase == "CH", 1, 0)
OJ.test$Purchase <- ifelse(OJ.test$Purchase == "CH", 1, 0)
#bagging
bag1 <- randomForest(Purchase ~ . , mtry = 17, data = OJ, subset = train, importance = TRUE)
bag1
yhat.bag <- predict(bag1, newdata = OJ.test)
plot(yhat.bag, OJ.test$Purchase)
abline(0, 1)
mean( (yhat.bag - OJ.test$Purchase)^2 )
#random forest
set.seed(123)
oob.error <- NA
val.set.error <- NA
for ( idx in 1:17){
  rf1 <- randomForest(Purchase ~ ., mtry = idx, data = OJ, subset = train, importance = TRUE)
  # record out of bag error
  oob.error[idx] <- rf1$mse[length(rf1$mse)]
  cat(paste("\n", "Use ", idx, " variables at each split", sep=""))
  # record validation set error
  val.set.error[idx] <- mean( (predict(rf1, newdata = OJ.test) - OJ.test$Purchase)^2 )
}
matplot( 1:idx, cbind(oob.error, val.set.error), pch = 19, col = c("red", "blue"), type = "b", ylab = "MSE", frame.plot = FALSE)
legend("topright", legend = c("OOB", "Val. Set"), pch = 19, col = c("red", "blue"),bty = "n")
val.set.error
oob.error
rf1 <- randomForest(Purchase ~ ., mtry = 4, data = OJ, subset = train, importance = TRUE)
yhat.rf <- predict(rf1, newdata = OJ.test)
mean( (yhat.rf - OJ.test$Purchase)^2 )
#boosting
library(gbm)
set.seed(1234)
# applying gradient boosting
gb1 <- gbm(Purchase ~ ., data = OJ[train, ], distribution = "gaussian", n.trees = 5000, interaction.depth = 4,shrinkage = 0.001)
summary(gb1)
# predicting outcome
yhat.gb <- predict(gb1, newdata = OJ.test, n.trees = 5000)
mean( (yhat.gb - OJ.test$Purchase)^2 )
#logistic regression
glm.fit <-  glm(Purchase ~ . , data=OJ.train, family="binomial")
glm.probs <-  predict(glm.fit, newdata=OJ.test, type = "response")
glm.class <- ifelse(glm.probs > 0.5, 1, 0)
sum(glm.class == OJ.test$Purchase) / nrow(OJ.test)
sum(glm.class != OJ.test$Purchase) / nrow(OJ.test)
