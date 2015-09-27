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

train_data_index <- createDataPartition(y=train_data$classe, p = 0.7, list=FALSE)
validation_data <- train_data[-train_data_index,]
train_data <- train_data[train_data_index,]

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

# preprocessing validation data
preprocess_validation_data <- validation_data[,-120]
imputed_validation_data <- predict(preProcess(preprocess_data, method="knnImpute"), preprocess_validation_data)
pca_validation_data <- predict(preProcess(imputed_data, method="pca"), imputed_validation_data)

# random tree validation
predictions_rf <- predict(model_rf, pca_validation_data)
confusionMatrix(predictions_rf, validation_data$classe)

# boosting with trees validation
predictions_gbm <- predict(model_gbm, pca_validation_data)
confusionMatrix(predictions_gbm, validation_data$classe)

# preprocessing test data
preprocess_test_data <- test_data[,-120]
imputed_test_data <- predict(preProcess(preprocess_data, method="knnImpute"), preprocess_test_data)
pca_test_data <- predict(preProcess(imputed_data, method="pca"), imputed_test_data)

# random tree test
test_rf <- predict(model_rf, pca_test_data)
confusionMatrix(test_rf, test_data$classe)

# boosting with trees test
test_gbm <- predict(model_gbm, pca_test_data)
confusionMatrix(test_gbm, test_data$classe)


# report
library(knitr)
knit2html("report.Rmd")
