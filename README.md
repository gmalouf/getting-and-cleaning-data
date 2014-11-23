<<<<<<< HEAD
----
## Getting and Cleaning Data - Course Project Submission

My solution to the [Getting and Cleaning Data](https://class.coursera.org/getdata-009) course project can be found here.  The purpose of the project was to demonstrate our ability to leverage the techniques taught in the course on a 'real world' data set.  

———-
## File Index

* run_analysis.R - Script that retrieves the source data and performs the necessary transformations to produce our tidy data set 
* CodeBook.md - File that describes the output produced by run_analysis.R including an overview of the features from which the data set was derived from.
* README.md - The file you are reading now


———-
## Run Analysis Walkthrough

To use the run_analysis.R script to produce the tidy data, please:

1. Source run_analysis.R from an R shell/RStudio.
2. execute the function runAnalysis() - note the optional workDirectory argument which defaults to current R working directory

For ease of implementation, the functionality in run_analysis.R takes the following approach to producing the tidy data set:

1. Downloads and unpacks the source data from the [Project Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Reads in the feature names, X training and X test data files - the feature/column labels are applied to the latter two files at read time using the 'col.names' option on read.table
3. Reads in the activity training and test files - the activity column gets named 'Activity Label'
4. Reads in the subject training and test files - the subject ids column gets named 'Subject ID'
5. The training and test data frames (X, y and subject files) are each respectively put together via cbind
6. The training and test data frames are combined using rbind
7. Any columns not matching the grep pattern 'mean|std|Activity.Label|Subject.ID' are filtered out of the data set 
8. The descriptive activity labels from activity_labels.txt are used to replace the numeric ids for activities in our 'Activity.Label' column.
9. The data set gets melted and decasted so that means for each unique Subject.ID, Activity.Label and Feature can be calculated.
10. The data set is melted again to ensure we end up with a long format where the columns are as described in the accompanying CodeBook.md.
11. Finally, the data set is written as a table to a file named 'GettingAndCleaningDataCourseProject-TidyDataOutput' in the previously specified 'workDirectory'.



=======
getting-and-cleaning-data
=========================
>>>>>>> 1065fd150dca7c6b7fe65f79aa4fc0dc1cf18564
