#Code Book 

#Project description
This project concerns data collected from the accelerometers from the Samsung Galaxy S smartphone.
The goal is to create a tidy dataset of the training and test data of this experiment and create a tidy dataset with only the mean and standard deviation for each measurement and then create an independent tidy dataset with the average of each variable for each activity and each subject.

The following paragraphs will go into this in more detail.

## Description of raw dataset

### Design of the experiment to collect the raw data
The experiments in the raw dataset have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities 
WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 
3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected
for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the 
time and frequency domain. 

###Features in the file
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ   
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag


### Files in the raw dataset

The raw dataset is a zipfile which contains 28 seperate files. For this project, only a selection of the files is needed:  
*test data*  
- X\_test.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 			test data  
- y\_test.txt &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			test activities  
- subject\_test.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test subjects  
- *training data*  
- X\_train.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			training data  
- y\_train.txt &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		training activities  
- subject\_train.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	training subjects  
- *general files*  
- activity\_labels.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	labels of the activities in y\_test.txt and y\_train.txt  
- features.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			labels of the variables in X\_test.txt and X\_train.txt  
- features\_info.txt		file with a clarification of the features in features.txt

The section about creating an tidy dataset will refer only to these files of the raw data. 

##Creating a tidy dataset
The raw data can be downloaded from http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The following steps have to be taken to create the tidy dataset tidydata.txt:

#### Renaming
None of the columns in the raw datafiles above have a descriptive name. Therefore, the variables in all test and training data had to be renamed. Besides this, the variable names are made more tidy and value labels were added to the file: 

1. The single column of subject\_test.txt and subject\_train.txt have been renamed to 'subject'
2. The single column of y\_test.txt and y\_train.txt have been renamed to 'activity'
3. The measures in X\_test.txt and X\_train.txt have been renamed based on the second column of the features.txt file. To achieve this, the first column was dropped and the second column was transposed before the names were used.
4. The variables in the tidy dataset were adjusted by removing the characters "()" and replace "-" by "_". This was done to make the names more syntactically valid (based on make.names).In my opinion, there was no need to make other changes in the names of the variables as the names in the features.txt file were well descriptive.
5. The activities were labelled by replacing the codes by the activity labels (based on activity_labels.txt)

####Creating the full datafile

As mentioned above, the raw dataset consist of separate files, which have to be merged together. This was done with the following steps:

1. Creating a file of the test condition, by adding the codes of the test subjects (from subject\_test.txt) and the codes for the activities (from y\_test.txt) as columns to the test data in X\_test.txt.
2. Creating a file of the training condition, by adding the codes of the training subjects (from subject\_train.txt) and the codes for the activities (from y\_train.txt) as columns to the training data in X\_training.txt.
3. Adding all the rows of the total files of the test condition and training condition together. 

The result is a data.frame with 10299 observations and 563 variables (subject, activity and 561 measurements)

#### Selecting only the variables which contain the mean of the standard deviation
In the raw dataset, the following measurements of the different features were estimated:

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.   
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal   
kurtosis(): kurtosis of the frequency domain signal   
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

In the tidy dataset only the mean() and std() measurement of the features are preserved. The additional vectors that were obtained by averaging the signals in a signal window sample were left out of the tidy data, because these were calculated later and are not based on the originally measured features. 

The result is a data.frame with 10299 observations and 68 variables (Subject, Activity and 66 measurements of mean and standard deviation)

####Create an independent tidy data set with the average of each variable for each activity and each subject.
For every subject, multiple measurements per activity were taken. In this step, an average score per subject per activity was calculated for each variable.

In the tidy dataset, the results are ordered first by subject and then by activity. This results in 1 observation per subject of each of the 6 activities.

The result is a the tidy data.frame tidydata.txt with 180 observations ang 68 variables (subject, activity and 66 measurements of mean and standard deviation)


## Description of the tidy dataset
The data.frame tidydata contains 68 variables and 180 observations. 
The tidy dataset contains the average of the separate measurements per subject(volunteer) per activity.
The variables are the subject, the activity and 66 measurements of the mean and standard deviation of the different features. 
See the README.md file for more information about how the tidy dataset was created.

## Description of the variables in the tidy dataset
The different variables in the dataset are described below. Because the variables of the mean and standard deviation of the features share the same characteristics, these are described together
For a more elaborated description of the features, I point to the desciption in the 'features in the file' section of the codebook. 



- subject
     - numeric variable; each number corresponds to a volunteer who participated in the project
	 - Values 1:30.
 


- activity
 + character variable indicating the 6 activities the person performed
 + Values WALKING, WALKING\_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

- mean of the features
 + variables tBodyAcc\_mean, tBodyAcc\_mean\_Y, tBodyAcc\_mean\_Z, tGravityAcc\_mean\_X, tGravityAcc\_mean\_Y, tGravityAcc\_mean\_Z, tBodyAccJerk\_mean\_X, tBodyAccJerk\_mean\_Y, tBodyAccJerk\_mean\_Z, tBodyGyro\_mean\_X, tBodyGyro\_mean\_Y, tBodyGyro\_mean\_Z, tBodyGyroJerk\_mean_X, tBodyGyroJerk\_mean\_Y, tBodyGyroJerk\_mean\_Z, tBodyAccMag\_mean, tGravityAccMag\_mean, tBodyAccJerkMag\_mean, tBodyGyroMag\_mean, tBodyGyroJerkMag\_mean, fBodyAcc\_mean\_X, fBodyAcc\_mean\_Y, fBodyAcc\_mean\_Z, fBodyAccJerk\_mean\_X, fBodyAccJerk\_mean\_Y, fBodyAccJerk\_mean\_Z, fBodyGyro\_mean\_X, fBodyGyro\_mean\_Y, fBodyGyro\_mean\_Z, fBodyAccMag\_mean, fBodyBodyAccJerkMag\_mean, fBodyBodyGyroMag\_mean, fBodyBodyGyroJerkMag\_mean
 + numeric variables
 + average score of all measurements per subject per activity
 + normalized and bounded within [-1,1]

- standard deviation of the features
 +variables tBodyAcc\_std\_X, tBodyAcc\_std\_Y, tBodyAcc\_std\_Z, tGravityAcc\_std\_X, tGravityAcc\_std\_Y, tGravityAcc\_std\_Z, tBodyAccJerk\_std\_X,tBodyAccJerk\_std\_Y, tBodyAccJerk\_std\_Z, tBodyGyro\_std\_X,tBodyGyro\_std_Y,tBodyGyro\_std\_Z, tBodyGyroJerk\_std\_X, tBodyGyroJerk\_std\_\Y, tBodyGyroJerk\_std\_Z, tBodyAccMag\_std, tGravityAccMag\_std, tBodyAccJerkMag\_std, tBodyGyroMag\_std, tBodyGyroJerkMag\_std,fBodyAcc\_std\_X, fBodyAcc\_std\_Y, fBodyAcc\_std\_Z, fBodyAccJerk\_std\_X, fBodyAccJerk\_std\_Y,fBodyAccJerk\_std\_Z, fBodyGyro\_std\_X, fBodyGyro\_std\_Y, fBodyGyro\_std\_Z, fBodyAccMag\_std, fBodyBodyAccJerkMag\_std, fBodyBodyGyroMag\_std, fBodyBodyGyroJerkMag\_std
 + numeric variables
 + average score of all measurements per subject per activity
 + normalized and bounded within [-1,1]



##License

Use of the dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

