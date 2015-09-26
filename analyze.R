# work environment
setwd("F:\\Google Drive\\Study\\Coursera\\Practical Machine Learning\\Course Project")
library(caret)

# read data
data <- read.table("data\\pml-training.csv", header = TRUE, sep = ",", colClasses = c( rep("character", 6), rep("numeric", 5), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 42), rep("character", 6), rep("numeric", 12), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 23), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 19), rep("character", 1) ))

# select only numeric columns
data_columns <- sapply(data, is.numeric)
data_columns['classe'] = TRUE
data <- data[data_columns]
data$classe <- as.factor(data$classe)

# data slicing
train_data_index <- createDataPartition(y=data$classe, p = 0.7, list=FALSE)
train_data <- data[train_data_index,]
test_data <- data[-train_data_index,]

# preprocessing
preprocess_data <- train_data[,-120]
# imputing
imputed_data <- predict(preProcess(preprocess_data, method="knnImpute"), preprocess_data)
# pca
pca_data <- predict(preProcess(imputed_data, method="pca"), imputed_data)

# boosting with trees model
model_gbm <- train(train_data$classe ~ ., method="gbm", data = pca_data)

# random tree model
model_rf <- train(train_data$classe ~ ., method="rf", data = pca_data, prox=TRUE)

# additive logistic regression boosting model
model_ada <- train(train_data$classe ~ ., method="ada", data = pca_data)

# report
library(knitr)
knit2html("report.Rmd")
