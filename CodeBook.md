1. INITIAL (RAW) DATA

The initial data are available at http://archive.ics.uci.edu/ml/machine-learning-databases/00341/.
They are results of experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, authors captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Then, the initial data were saved into a number of .txt files, with two major subsets ("train" and "test").

2. VARIABLES CONTAINED IN THE RAW DATA

All variables are a result of a certain function applied to a readouts of certain signals.

2.1 The list of functions:
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

2.2 The list of signals:
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

General structure is:
<Type of data><Source of data><Add.tag1><Add.tag2><Coordinate>

- Type of data: "t" stands for time, "f" for frequency (result of Fast Fourier Transform (FFT) applied to some of these signals)
- Source of data: of three basic types, two come from accelerometer ("BodyAcc" and "GravityAcc") and anotheк one from gyroscope ("BodyGyro")
- Add.tag1 (optional): the body linear acceleration and angular velocity were derived in time to obtain Jerk signals ("Jerk" tag)
- Add.tag2 (optional): the magnitude of these three-dimensional signals were calculated using the Euclidean norm
- Coordinate (optional): X, Y, Z

2.3 Units
The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/s2). The gyroscope units are rad/s. 
Authors used "seg" instead of "s", which might be due to Spanish

3. PROCESSING OF DATA

3.1. The data (both "train" and "test") were consolidated into one dataset.
3.2. Then it was cleared of all data except for "mean" and "standard deviation" results.
3.3. Each activity id was supplemented with it's short description ("walking", "sitting" and so on).
3.4. Variable names were changed into more readable form.
3.5. After that, a tidy data set was created, where all variables were averaged relating to each subject and each activity number.