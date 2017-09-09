# CodeBook

I this code Book we indicate all the variables and summaries calculated, along with units, and any other relevant information related the **run_analysis.R** script.

The output of the code is the tidy_data_set.txt file attached to this project repo.

The handle files use in the script are described above.

### loaded raw files.

fist of all we lead and store the raw files of the tran ans test data sets in R.

* activity_labels - Links the class labels with their activity name.

* features_labels - List of all features.

* subject_train -  column vector with the subject ids in the order of x_train data set rows or observations.

* x_train - table containig all 563 features calculated upon the measured raw data values of aceleration and gyroscope momentum. 

* y_train - column vector with the values of activitu ids in the order of the

the analogous decription holds for the sets subject_test, x_test, y_test.

 
### binding and merging sets

The columns of the above sets are binded and merged in the handling files:

* train_set - column bind of the subject_train,y_train,x_train.
* test_set -column bind of the subject_test,y_test,x_test. 

* merged_set - bind all rows of each data set into a single data frame.

### Mean ans standard deviation features.

In Step 2 we extracts only the measurements on the mean and standard deviation for each measurement. the following handling files are created internally to perform this task.

meancols - fetch of the columns indices for which we match the character "mean". It means that the selected column indeces corresponds to features associated with averages of sensors measured values. 
stdcols - the same as above but for standard deviation.

We select the mean and std related features from the merged_set and stores it internally in the global environmant of R with the name

* mean_std_set

the list of features selecter are shown below.

* tBodyAccMeanX
* tBodyAccMeanY
* tBodyAccMeanZ
* tBodyAccStdX
* tBodyAccStdY
* tBodyAccStdZ
* tGravityAccMeanX
* tGravityAccMeanY
* tGravityAccMeanZ
* tGravityAccStdX
* tGravityAccStdY
* tGravityAccStdZ
* tBodyAccJerkMeanX
* tBodyAccJerkMeanY
* tBodyAccJerkMeanZ
* tBodyAccJerkStdX
* tBodyAccJerkStdY
* tBodyAccJerkStdZ
* tBodyGyroMeanX
* tBodyGyroMeanY
* tBodyGyroMeanZ
* tBodyGyroStdX
* tBodyGyroStdY
* tBodyGyroStdZ
* tBodyGyroJerkMeanX
* tBodyGyroJerkMeanY
* tBodyGyroJerkMeanZ
* tBodyGyroJerkStdX
* tBodyGyroJerkStdY
* tBodyGyroJerkStdZ
* tBodyAccMagMean
* tBodyAccMagStd
* tGravityAccMagMean
* tGravityAccMagStd
* tBodyAccJerkMagMean
* tBodyAccJerkMagStd
* tBodyGyroMagMean
* tBodyGyroMagStd
* tBodyGyroJerkMagMean
* tBodyGyroJerkMagStd
* fBodyAccMeanX
* fBodyAccMeanY
* fBodyAccMeanZ
* fBodyAccStdX
* fBodyAccStdY
* fBodyAccStdZ
* fBodyAccMeanFreqX
* fBodyAccMeanFreqY
* fBodyAccMeanFreqZ
* fBodyAccJerkMeanX
* fBodyAccJerkMeanY
* fBodyAccJerkMeanZ
* fBodyAccJerkStdX
* fBodyAccJerkStdY
* fBodyAccJerkStdZ
* fBodyAccJerkMeanFreqX
* fBodyAccJerkMeanFreqY
* fBodyAccJerkMeanFreqZ
* fBodyGyroMeanX
* fBodyGyroMeanY
* fBodyGyroMeanZ
* fBodyGyroStdX
* fBodyGyroStdY
* fBodyGyroStdZ
* fBodyGyroMeanFreqX
* fBodyGyroMeanFreqY
* fBodyGyroMeanFreqZ
* fBodyAccMagMean
* fBodyAccMagStd
* fBodyAccMagMeanFreq
* fBodyBodyAccJerkMagMean
* fBodyBodyAccJerkMagStd
* fBodyBodyAccJerkMagMeanFreq
* fBodyBodyGyroMagMean
* fBodyBodyGyroMagStd
* fBodyBodyGyroMagMeanFreq
* fBodyBodyGyroJerkMagMean
* fBodyBodyGyroJerkMagStd
* fBodyBodyGyroJerkMagMeanFreq


### Descriptive names
In Step 3 we uses descriptive activity names to name the activities in the data set using the activivy names in the second column of the activity_labels data set downloaded. the code uses the functions merge and select of (dplyr) package.

```
merged_set<-merge(merged_set,activity_labels, by="activityID")

merged_set<-merged_set%>%select(activity_name,everything(),-activityID)
```



### Changing names of columns
In the Step 4 we appropriately labels the data set with descriptive variable names. the we store the abbreviated names in the table abbrav_names.

after a lot of modifications in the abbreviated names we store the complete names of the features in the table full_names. 

```
abbrav_names <- names(merged_set)
abbrav_names <- make.names(abbrav_names)

abbrav_names <- gsub('mad',"MedianAbsDeviation",abbrav_names)
abbrav_names <- gsub('arCoeff',"Autorregresion coefficients_Burg=4",abbrav_names)
abbrav_names <- gsub('iqr',"InterquartileRange",abbrav_names)
abbrav_names <- gsub('Acc',"Acceleration",abbrav_names)
abbrav_names <- gsub('GyroJerk',"AngularAcceleration",abbrav_names)
abbrav_names <- gsub('Gyro',"AngularSpeed",abbrav_names)
abbrav_names <- gsub('Mag',"Magnitude",abbrav_names)
abbrav_names <- gsub('^t',"TimeDomain.",abbrav_names)
abbrav_names <- gsub('^f',"FrequencyDomain.",abbrav_names)
abbrav_names <- gsub('\\.std',".StandardDeviation",abbrav_names)
abbrav_names <- gsub('Freq\\.',"Frequency.",abbrav_names)
abbrav_names <- gsub('Freq$',"Frequency",abbrav_names)
abbrav_names <- gsub('iqr',"InterquartileRange",abbrav_names)
abbrav_names<-gsub('\\.\\.\\.',".-",abbrav_names)
#abbrav_names
full_names<-abbrav_names

colnames(merged_set)<-full_names
```

### Tidy data set
In the Step 5 we create a second, independent tidy data set with the average 
of each variable for each activity and each subject. we called it internally "tidy_avg_set". We write ans export this tidy data set as a .txt file with the name "tidy_data_set.txt".

```
tidy_avg_set<-merged_set%>%group_by(activity_name,subjectID)%>%summarise_all(mean)

write.table(tidy_avg_set,file="tidy_data_set.txt",row.name=FALSE)

```
###### Ok work done!


### Activity Label names and description

+ WALKING (value 1): subject was walking during the test
+ WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
+ WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
+ SITTING (value 4): subject was sitting during the test
+ STANDING (value 5): subject was standing during the test
+ LAYING (value 6): subject was laying down during the test



© 2017 
Pedro Ramon Almeida Oiticica<br />
All rights reserved.
