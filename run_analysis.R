##  data collected from the accelerometers from the Samsung 
##   Code book  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
##   Data here : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##use libraries
require(dplyr)
require(tidyr)
require(reshape2)
##download zip file
setwd("C:/Projects/Coursera/course_cleaningdata/projectfields")

##   download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "d.zip")
##  unzip("d.zip")
##  list.files()

list.dirs()

##Activity set
activities <- c("Walking", "Walking_upstairs",  "Walking_Down_Stairs",  "Sitting", "Standing",  "Laying")

##bring data into R
## test sets
tests.1 <- read.table("./UCI HAR Dataset/test/x_test.txt",header = T)
## Lables
tests.2 <- read.csv("./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
## subjects
tests.3 <- read.csv("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
tests <- data.frame(subjects = tests.3$X2, labelnames = tests.2$X5, testsets = tests.1)
head(tests[,1:2])
tests <- mutate(tests,group = "test")

##melt databset
tests.tidy  <- melt(tests,id.vars = c("group","subjects","labelnames"))


## Train set
train.1 <- read.table("./UCI HAR Dataset/train/x_train.txt" ,header = T)
train.2 <- read.csv("./UCI HAR Dataset/train/y_train.txt")
train.3 <- read.csv("./UCI HAR Dataset/train/subject_train.txt")

train <- data.frame(subjects = train.3$X1, labelnames = train.2$X5, testsets = train.1)
train <- mutate(train,group = "train")
train.tidy  <- melt(train,id.vars = c("group","subjects","labelnames"))


## no. 1  Merges the training and the test sets to create one data set.
tidyset <- rbind.data.frame(tests.tidy,train.tidy)


## no. 3 Uses descriptive activity names to name the activities in the data set
tidyset$labelnames <- activities[tidyset$labelnames]


## No. 2 Extracts only the measurements on the mean and standard deviation for each measurement.
dfset <- tbl_df(tidyset)
no2 <-  dfset %>% group_by(variable)  %>% summarise(measure_mean = mean(value), measure_sd = sd(value))


# no 4 Appropriately labels the data set with descriptive variable names
tidyset.renamed <- tidyset %>% rename(subject_id = subjects , activity = labelnames, measure_ob = variable) 
head(tidyset.renamed)

# no 5 creates a second, independent tidy data set with the average of each variable for each activity and each subject
 tidyset.renamed %>% group_by(activity, measure_ob) %>% na.exclude %>% mean(value)
class(tidyset.renamed$value)
 
bag <- tidyset.renamed %>% group_by(subject_id, activity) %>% summarise( mactvity = mean(value)) %>% spread(activity,mactvity)  
no5 <- mutate(bag, row_arg = rowMeans(bag[,2:6]))
  