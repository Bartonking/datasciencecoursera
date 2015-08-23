# datasciencecoursera
Human Activity Recognition Using Smartphones Dataset


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


Code file: "run_analysis.R"

The code is divided into 5 areas starting from the top to the bottom.

### Section 1: setting project
1. Identifies  the libraries that are used in the execution of the code.  
2. sets the working location of the workspace for the project
3. Downloads the files from the website and unzips it

### Section 2: preparing the dataset
The data is read into  R as separate dataframs.  Test data is handled first and then the trainning set.   In the creation of the tidy databset i decided not to process the variable column futher because there was no specific request that required that column to be devided any further.  Also futher processing would have, unnecessarily create additional columns that would have been edited out later.

#### Test Files
1. Create a dataframe for each file  tests.1 = x_test.txt, test.2 = y_test.txt, test.3 = subject_test.txt
2. Combine the dataframes into a single dataframe  
3. Melt the dataset into a tidy dataset.  :  columns :   subjects, labelnames, variable and value

###  Train Files  (process repeated for the Train set)
1. Create a dataframe for each file  Train.1 = x_Train.txt, Train.2 = y_Train.txt, Train.3 = subject_Train.txt
2. Combine the dataframes into a single dataframe  
3. Melt the dataset into a tidy dataset.  :  columns :   subjects, labelnames, variable and value

### Section 3. doing the Exercise

##### No. 1
After the two tidy dataframes have been created,  there are merged with rbind  to create a single dataset.

##### No. 2
The dataset is then grouped and summarized by mean and standard deviation

##### No. 3
The activities names are then added to the database to provide better information for presentation

##### No. 4
The label names for the tidy dataset is updated to provide a better descriptive presentation Please see the code book for details of the names used

##### No. 5
The dataset is then grouped by the volunteer's id and the actvitity type.  The results is summarized by the mean of the activity and spread out to create a new columne for each activity shown the arverage amount.  To complete the data presentation, a next column is added for the row average.   

Finally the scripts writes the results to a text file. run_analsys_031_barton.txt



