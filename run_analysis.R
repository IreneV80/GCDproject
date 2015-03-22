# Opening the dplyr package
library(dplyr)

# Creating a new folder in the working directory
if (!file.exists("CourseProjectGCD")) {
        dir.create ("CourseProjectGCD")
}

# Downloading and unzipping the data
fileURL<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./CourseProjectGCD/projectGCD.zip") 
files<-unzip("./CourseProjectGCD/projectGCD.zip", exdir="./CourseProjectGCD/unzipped")

# Read the file containing the features, keep only the column with the feature names and transpose the data.
features<-read.table(files[2])
names(features)[2]<-"features"
features2<-subset(features, select=features)
features2<- t(features2)

#Preparing the training file
#read the files concerning the training condition into R
trainsubject<-read.table(files[26])     # reads the training subjects into R
trainresults<- read.table(files[27])    # reads the training results into R
trainactivity<-read.table(files[28])    # reads the training activities into R


#Rename the variables in the trainsubject, trainactivity and trainresult files

names(trainactivity)[1]<-"activity"
names(trainsubject) [1]<-"subject"
names(trainresults)[1:561]<-features2

#create one file with the training subjects, training activities and the traindata
traindata<-cbind(trainsubject,trainactivity,trainresults, stringsAsFactors = FALSE)

#Preparing the test file
#read the files concering the testing conditing into R

testsubject<-read.table(files[14])      # reads the test subjects into R
testresults<- read.table(files[15])     # reads the test results into R
testactivity<-read.table(files[16])     # reads the test activities into R


#rename the variables in the testsubject, testactivity and testresult file

names(testactivity)[1]<-"activity"
names(testsubject) [1]<-"subject"
names(testresults)[1:561]<-features2

#Create one file with the test subjects, test activities and the testdata
testdata<-cbind(testsubject,testactivity,testresults, stringsAsFactors = FALSE)


#Merging the training dataset with the test dataset
totaldata<-rbind(traindata,testdata)

#Selecting only the variables which contain mean or std of the initial features
subset<-totaldata[grep("subject|activity|mean()|std",names(totaldata), ignore.case=FALSE, value=TRUE)]
subsetdata <- subset[-grep("meanFreq", names(subset))] 

#Tidy the variable names by removing the characters "()" and replace "-" by "_"

subsetnames<-gsub(pattern="\\()",replacement="",names(subsetdata)[1:68])
subsetnames<-gsub(pattern="\\-",replacement="_",subsetnames)
names(subsetdata)[1:68]<-subsetnames

#Creates a new dataset based on the mean of the different measurements of mean and std per activity per subject

tidy<-aggregate(subsetdata,by=list(subsetdata$activity,subsetdata$subject),FUN=mean)
tidydata<-select(tidy, -starts_with("Group"))

#Change labels of the activities: replace the codes by the activity labels

tidydata$activity[tidydata$activity=="1"]<-"WALKING"
tidydata$activity[tidydata$activity=="2"]<-"WALKING_UPSTAIRS"
tidydata$activity[tidydata$activity=="3"]<-"WALKING_DOWNSTAIRS"
tidydata$activity[tidydata$activity=="4"]<-"SITTING"
tidydata$activity[tidydata$activity=="5"]<-"STANDING"
tidydata$activity[tidydata$activity=="6"]<-"LAYING"

# Create a .txt file of the tidy data
write.table(tidydata,file="./CourseProjectGCD/tidydata.txt",row.names=FALSE)