# README 

## Description of the raw dataset

This project concerns data collected from the accelerometers from the Samsung Galaxy S smartphone.

The experiments in the raw dataset have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities(WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Please see the CodeBook.md for a more details about the set-up of  the experiment, the measures in the dataset and the way they were collected.


## Description of the tidying process
The purpose of the tidying process with the run.analysis.R script is to merge the the two datasets with the training and test data together again, keeping only the measurements on the mean and standard deviation 
for each measurement and create an independent tidy dataset with the average of each variable for each activity and each subject.

To achieve a tidy dataset, variable names and labels were also adjusted.  See de CodeBook.md for more details.

##Files
Besides this README.md, there are several files needed to obtain and interpret the tidy dataset

-  **The raw dataset** 
This can be obtained from: *http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip* 
See the Codebook for more details about the dataset and the files used.
- **run.analysis.R script**
The script to transform the raw dataset into the tidy dataset. This is described in more detail below
- **CodeBook.md**
In the codebook you can find a description of the data in more detail, a description of the tidying process and the choices that were made and a description of the different variables in the tidy dataset.



## Conditions to run the script
To run the run.analysis.R script, the **dplyr package** needs to be installed.


##Description of the run.analysis.R script
The run.analysis.R script will create one dataset of the training and test datafiles, keeping only the measures of mean and standard deviation of the different features (see CodeBook,md). 
The multiple measurements per subject are then averaged per activity, so that only one score per subject per activity remains.
The script will perform the following actions:

1. Opens de dplyr package
2. Creates a new folder in the working directory, gets the data from the web, saves the zip and extracts the files.
3. Reads the file containing the features into R, keep only the column with the feature names and transpose the data so it can be used as variable names for the X\_test.txt and X\_train.txt files
4. Reads the training files into R, renames the variables in the dataframes, and creates a new dataframe where the subjects (subject\_train.txt) and activities (y\_train.txt) are added to the results file (X_train.txt)
5. Reads the test files into R, renames the variables in the dataframes, and creates a new dataframe where the subjects (subject\_test.txt) and activities (y\_test.txt) are added to the results file (X_train.txt)
6. Combines the training and test data using Rbind to create the totaldata file
7. Selecting only the variables which contain mean or std of the initial measurements. 
8. Tidies the variable names by removing the characters "()" and replace "-" by "_". 
9. Creates a new dataset based on the average of the separate measurements of mean and std per activity per subject
10. Labels the activities by replacing the codes by the activity labels (based on activity_labels.txt)
11. Saves the tidy dataset as a .txt file: tidydata.txt 



##License

Use of the dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
