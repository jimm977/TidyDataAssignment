The "run_analysis.R" script reads data saved to /train and /test folders (namely, train/subject_train.txt, train/X_train.txt, train/Y_train.txt, test/subject_test.txt, test/X_test.txt, test/Y_test.txt), thus creating trainTb and testTb data.frames. 

It also reads features.txt, which is essentially a vector of column names for those data.frames

Step1 is to merge data sets; it is carried out with rbind function.
Step2 is to extract columns with mean and std. Their names contain "-mean()" and "-std()" tags.
Step3 is to add desriptions to activities. These descriptions are in the activity_labels.txt file, merge was through inner_join().
I didn't like that they are all capital letters there, so I tolowered() them except for the first one.
Step4 was labeling variables with descriptive names. It was done through gsub
Step5 - tidy dataset was created as a separate data.frame (tidyDataset), each row contains a unique combination of {PersonID; ActivityID} , averages were calculated with mean()

