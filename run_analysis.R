ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
xtrain <- read.table("UCI HAR Dataset/train/x_train.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
xtest <- read.table("UCI HAR Dataset/test/x_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
combined <- rbind(xtest, xtrain)
colnames(combined) <- features[,2]
extracted <- combined[,grep("[mM]ean|std",features[,2])]
labels <- rbind(ytest, ytrain)
colnames(labels) <- "activitydescription"
labels[which(labels[,1] == 1),1] <- "WALKING"
labels[which(labels[,1] == 2),1] <- "WALKING_UPSTAIRS"
labels[which(labels[,1] == 3),1] <- "WALKING_DOWNSTAIRS"
labels[which(labels[,1] == 4),1] <- "SITTING"
labels[which(labels[,1] == 5),1] <- "STANDING"
labels[which(labels[,1] == 6),1] <- "LAYING"
labeled <- cbind(labels, extracted)
subjects <- rbind(subjecttest, subjecttrain)
colnames(subjects) <- "subjectid"
wholeset <- cbind(subjects, labeled)
library(reshape2)
wholemelt <- melt(wholeset, id = names(wholeset[1:2]), measure.vars = names(wholeset[3:88]))
avgwholemelt <- acast(wholemelt, subjectid ~ activitydescription ~ variable, mean)
write.table(avgwholemelt, "tidydataset.txt")