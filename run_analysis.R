library(plyr)
library(reshape2)

# Main script function that executes all of the individual steps necessary to generate 
# and persist our new tidy data set.
runAnalysis <- function(workDirectory = getwd()) {
  uciDirectory = uciDataSetDir(workDirectory)
  pullSourceData(uciDirectory, workDirectory)
  cbd = buildCombinedDataSet(uciDirectory) 
  fcdb = filterFeaturesForMeanStd(cbd)
  fcdb$Activity.Label = applyActivityDescriptiveNames(uciDirectory, fcdb)
  tidyDataSet = createTidyDataSet(fcdb)
  persistDataSet(tidyDataSet, workDirectory)
}

# If HAR source data is unpacked, retrieve/download it (if necessary) and unzip 
# in workDirectory.
pullSourceData <- function(uciDirectory, workDirectory) {
  if(!file.exists(uciDirectory)) {
    harDataUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    harDataZipFile = paste(workDirectory, 'getdata_projectfiles_UCI HAR Dataset.zip', sep = '/')
    if(!file.exists(harDataUrl)) {
      download.file(harDataUrl, destfile = harDataZipFile, method = 'curl')  
    }
    unzip(harDataZipFile, exdir = workDirectory)
  }
}

# Builds the combined data set made up of training and test data.  Column labels 
# are added here as well.
buildCombinedDataSet <- function(uciDirectory) {
  
  # Load feature labels and training/test feature data.  Note that labels are applied to the columns.
  featureNames = make.names(readWisely(fullFilePath(uciDirectory, "features.txt"))[,2], unique = TRUE)
  labeledxtrain = readWisely(fullFilePath(uciDirectory, "train/X_train.txt"), featureNames)
  labeledxtest = readWisely(fullFilePath(uciDirectory, "test/X_test.txt"), featureNames)
    
  # Load activity records from training/test data.
  ytrain = readWisely(fullFilePath(uciDirectory, "train/y_train.txt"), c('Activity Label'))
  ytest = readWisely(fullFilePath(uciDirectory, "test/y_test.txt"), c('Activity Label'))
    
  # Load training/test subject records.
  subjecttrain = readWisely(fullFilePath(uciDirectory, "train/subject_train.txt"), c('Subject ID'))
  subjecttest = readWisely(fullFilePath(uciDirectory, "test/subject_test.txt"), c('Subject ID'))
    
  # Combine the various training and test data files respectively by columns
  combinedtrainingdata = cbind(labeledxtrain, ytrain, subjecttrain)
  combinedtestdata = cbind(labeledxtest, ytest, subjecttest)

  # Combine the training and test data into a single data frame
  rbind(combinedtrainingdata, combinedtestdata)
}

# Given data set matchig expected columns, applies filters that eliminate any columns not 
# matching our desired pattern
filterFeaturesForMeanStd <- function(dataSet) {
  dataSet[,grep('mean|std|Activity.Label|Subject.ID', names(dataSet), ignore.case = TRUE)]
}

# Applies descriptive activity names if the given data set has an Activity.Label column
applyActivityDescriptiveNames <- function(uciDirectory, dataSet) {
  activityLabels = readWisely(fullFilePath(uciDirectory, "activity_labels.txt")) 
  
  sapply(dataSet$Activity.Label, function(x) { activityLabels[x,2] })
}

# Given our dirty, filtered data set with column labels, computes the 
# average of each variable for each subject and activity combination then organizes
# the data into a clean, columnar format.
createTidyDataSet <- function(dirtyDataSet) {
  melted = melt(dirtyDataSet, id.vars = c("Subject.ID", "Activity.Label"))
  meanCalculated = dcast(melted, Subject.ID + Activity.Label ~ variable, mean)
  melt(meanCalculated, id.vars = c("Subject.ID", "Activity.Label"), 
       variable.name = "Feature", value.name = "Mean")
}

# Writes out a data set to the outputDirectory specified
persistDataSet <- function(dataSet, outputDirectory) {
  if(!file.exists(outputDirectory)) {
    dir.create(outputDirectory)
  } 
  
  write.table(dataSet, file = "GettingAndCleaningDataCourseProject-TidyDataOutput.txt", 
              row.names = FALSE)
}

uciDataSetDir <- function(workDirectory) { paste(workDirectory, 'UCI HAR Dataset', sep='/') }

#Utility functions
readWisely <- function(filePath, col.names) {
  tab5rows <- read.table(filePath, header = TRUE, nrows = 5)
  classes <- sapply(tab5rows, class)
  read.table(filePath, colClasses = classes, col.names = col.names)    
}

fullFilePath <- function(directory, relativeFilePath) {
  paste(directory, relativeFilePath, sep="/")    
}

