———-
## Overview

This code book describes the decision-making process and variables used/produced in creating our tidy data set.

———-
## Source Data

The original 'source' data from which our tidy data set is derived can be found at [UCI HAR fixed DataSet](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

———-
## Output Data Format

The goal of this assignment was to produce a tidy data set that is easier to manipulate/work with than the source data.  Our tidy data set is output in what is referred to as a 'long' format.  Each row represents a single calculated average of observations for a unique combination of subject, activity and feature.  The columns include:

1. Subject.ID - unique identifier for a test subject
2. Activity.Label - Label describing the type of activity the subject took part in for a given observation
3. Feature - The type of measurement performed
4. Mean - The average of the value(s) produced for the unique subject, activity, feature combination

———-
## Key Decisions

When working through the assignment, one of the major decision points is to decide what is meant when one is asked to filter the features just for ones that represent the 'mean' and 'std'.  I interpreted this request to mean that any feature with the words 'mean' of 'std' in it should be considered to have passed the filter, regardless of case.  Based on this decision, I ended up with 86 features remaining for further calculations.

In terms of how the output data is formatted, I decided that based on the derived calculation requested from us in part 5, the feature names/types had become factors and were best represented as different entries under a 'Feature' column.  The results of the mean calculation are represented in an adjacent column called 'Mean' in this case.

———-
## Feature Description 

The features from which the tidy data file is derived come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

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

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
meanFreq(): Weighted average of the frequency components to obtain a mean frequency

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

