In this lab, please finish two following problems:
1.	This problem involves the OJ dataset (https://rdrr.io/cran/ISLR/man/OJ.html) which is part of the ISLR package (available on CougarView).
  1)	Create a training set containing a random sample of 800 observations, and a test set containing the remaining observations.
  2)	Fit a tree to the training data, with Purchase as the response and the other variables except for Buy as predictors. Use the summary() function to produce summary statistics about the tree, and describe the results obtained. What is the training error rate? How many terminal nodes does the tree have?
  3)	Type in the name of the tree object in order to get a detailed text output. Pick one of the terminal nodes, and interpret the information displayed.
  4)	Create a plot of the tree and interpret the results.
  5)	Predict the response on the test data and produce a confusion matrix comparing the test labels to the predicted test labels. What is the test error rate?
  6)	Produce a plot with tree size on the x�-axis and cross-validated classification error rate on the y�-axis.
  7)	Which tree size corresponds to the lowest cross-validated classification error rate?
  8)	Produce a pruned tree corresponding to the optimal tree size obtained using cross-validation. If cross-validation does not lead to selection of a pruned tree, then create a pruned tree with five terminal nodes.
  9)	Compare the training error rates between the pruned and unpruned trees. Which is higher?
  10)	Compare the test error rates between the pruned and unpruned trees. Which is higher?

2.	Apply boosting, bagging, and random forests to a data set of your choice. Be sure to fit the models on a training set and to evaluate their performance on a test set. How accurate are the results compared to simple methods like linear or logistic regression? Which of these approaches yields the best performance?
