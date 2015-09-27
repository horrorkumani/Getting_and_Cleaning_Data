packages <- c("data.table", "reshape2","memisc","plyr")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

setwd("C:/Users/HP/Documents/GitHub/Huong/UCI HAR Dataset")
path<- getwd()
data_feature <- paste(path,"/features.txt",sep="")
data_activity_labels <- paste(path, "/activity_labels.txt", sep = "")
data_x_train <- paste(path, "/train/X_train.txt", sep = "")
data_y_train <- paste(path, "/train/y_train.txt", sep = "")
data_subject_train <- paste(path, "/train/subject_train.txt", sep = "")
data_x_test <- paste(path, "/test/X_test.txt", sep = "")
data_y_test  <- paste(path, "/test/y_test.txt", sep = "")
data_subject_test <- paste(path, "/test/subject_test.txt", sep = "")

features <- read.table(data_feature, colClasses = c("character"))
activity_labels <- read.table(data_activity_labels, col.names = c("ActivityId", "Activity"))
x_train <- read.table(data_x_train)
y_train <- read.table(data_y_train)
subject_train <- read.table(data_subject_train)
x_test <- read.table(data_x_test)
y_test <- read.table(data_y_test)
subject_test <- read.table(data_subject_test)

training_sensor_data <- cbind(cbind(x_train, subject_train), y_train)
test_sensor_data <- cbind(cbind(x_test, subject_test), y_test)
sensor_data <- rbind(training_sensor_data, test_sensor_data)

sensor_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(sensor_data) <- sensor_labels


sensor_data_mean_std <- sensor_data[,grepl("mean|std|Subject|ActivityId", names(sensor_data))]

sensor_data_mean_std <- join(sensor_data_mean_std, activity_labels, by = "ActivityId", match = "first")
sensor_data_mean_std <- sensor_data_mean_std[,-1]

names(sensor_data_mean_std) <- gsub('\\(|\\)',"",names(sensor_data_mean_std), perl = TRUE)

names(sensor_data_mean_std) <- make.names(names(sensor_data_mean_std))

names(sensor_data_mean_std) <- gsub('Acc',"Acceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Mag',"Magnitude",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^t',"TimeDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.mean',".Mean",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq$',"Frequency",names(sensor_data_mean_std))

sensor_avg_by_act_sub = ddply(sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(sensor_avg_by_act_sub, file = "sensor_avg_by_act_sub.txt",row.name=FALSE)

x<-data.set(sensor_avg_by_act_sub)
description(x)
codebook(x)
Write(codebook(x),
      file="CodeBook.md")
