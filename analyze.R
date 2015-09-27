# work environment
setwd("F:\\Google Drive\\Study\\Coursera\\Practical Machine Learning\\Course Project")
library(caret)
set.seed(172843)

# read data
data <- read.table("data\\pml-training.csv", header = TRUE, sep = ",", colClasses = c( rep("character", 6), rep("numeric", 5), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 42), rep("character", 6), rep("numeric", 12), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 23), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 19), rep("character", 1) ))
question_data <- read.table("data\\pml-testing.csv", header = TRUE, sep = ",", colClasses = c( rep("character", 6), rep("numeric", 5), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 42), rep("character", 6), rep("numeric", 12), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 23), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 19), rep("character", 1) ))

# select only numeric columns
data_columns <- sapply(data, is.numeric)
data_columns['classe'] = TRUE
data <- data[data_columns]
data$classe <- as.factor(data$classe)

data_columns <- sapply(question_data, is.numeric)
question_data <- question_data[data_columns]

# data slicing
train_data_index <- createDataPartition(y=data$classe, p = 0.7, list=FALSE)
train_data <- data[train_data_index,]

train_data_index <- createDataPartition(y=train_data$classe, p = 0.7, list=FALSE)
train_data <- train_data[train_data_index,]

# preprocessing
preprocess_data <- train_data[,-120]
# imputing
impute_action <- preProcess(preprocess_data, method="knnImpute")
imputed_data <- predict(impute_action, preprocess_data)
# pca
pca_action <- preProcess(imputed_data, method="pca")
pca_data <- predict(pca_action, imputed_data)

# random forest model
model_rf <- train(train_data$classe ~ ., method="rf", data = pca_data, prox=TRUE)

# preprocessing question data
imputed_question_data <- predict(impute_action, question_data)
pca_question_data <- predict(pca_action, imputed_question_data)

# find answers
answers <- predict(model_rf, pca_question_data)
# A A B A A E D B A A B C B A E E A B B B

# write answers to file
for(i in 1:length(answers)) {
    filename = paste0("answers\\problem_id_", i, ".txt")
    write.table(answers[i], file=filename, quote=FALSE, row.names=FALSE, col.names=FALSE)
}
