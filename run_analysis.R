##  data collected from the accelerometers from the Samsung 
##   Code book  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
##   Data here : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Section 1

##use libraries
require(dplyr)
require(tidyr)
require(reshape2)
##download zip file
setwd("C:/Projects/Coursera/course_cleaningdata/projectfields")

##   download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "d.zip")
##  unzip("d.zip")


## Section 2

##bring data into R


## test sets
tests.1 <- read.table("./UCI HAR Dataset/test/x_test.txt",header = T)
## Lables
tests.2 <- read.csv("./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
## subjects
tests.3 <- read.csv("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)

## create dataframe for test group
tests <- data.frame(subjects = tests.3$X2, labelnames = tests.2$X5, testsets = tests.1)

##melt dataframe to create a tidy dataset for test
tests.tidy  <- melt(tests,id.vars = c("subjects","labelnames"))



##  repeat excerise for Train set
train.1 <- read.table("./UCI HAR Dataset/train/x_train.txt" ,header = T)
train.2 <- read.csv("./UCI HAR Dataset/train/y_train.txt")
train.3 <- read.csv("./UCI HAR Dataset/train/subject_train.txt")

train <- data.frame(subjects = train.3$X1, labelnames = train.2$X5, testsets = train.1)
##train <- mutate(train,group = "train")
train.tidy  <- melt(train,id.vars = c("subjects","labelnames"))

## Section 3
## -------- Data acquired and arrangedf or project task

## no. 1  Merges the training and the test sets to create one data set.
tidyset <- rbind.data.frame(tests.tidy,train.tidy)


## No. 2 Extracts only the measurements on the mean and standard deviation for each measurement.
dfset <- tbl_df(tidyset)  ## create a special dataframe
no2 <-  dfset %>% group_by(variable)  %>% summarise(measure_mean = mean(value), measure_sd = sd(value))


## no. 3 Uses descriptive activity names to name the activities in the data set
activities <- c("Walking", "Walking_upstairs",  "Walking_Down_Stairs",  "Sitting", "Standing",  "Laying")
tidyset$labelnames <- activities[tidyset$labelnames]


## no 4 Appropriately labels the data set with descriptive variable names
tidyset.renamed <- tidyset %>% rename(volunteer_id = subjects , activity = labelnames, measure_ob = variable) 


## no 5 creates a second, independent tidy data set with the average of each variable for each activity and each subject
bag <- tidyset.renamed %>% group_by(volunteer_id, activity) %>% summarise( mactvity = mean(value)) %>% spread(activity,mactvity)  
no5results <- mutate(bag, row_arg = rowMeans(bag[,2:6]))

## Generation a dataframe and store it to file
write.table("run_analsys_031_barton.txt",x = no5results, row.names = FALSE)
  