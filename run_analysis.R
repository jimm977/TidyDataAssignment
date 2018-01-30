## You should create one R script called run_analysis.R that does the following.

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.
library(dplyr)
headerV<-read.table("features.txt",
               sep="", header=FALSE, stringsAsFactors = FALSE)[,2]
actionV<-read.table("activity_labels.txt",
                    sep="", header=FALSE, stringsAsFactors = FALSE, col.names = c("ActivityID", "ActivityShortName"))

testTb<-cbind(read.table("test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE, col.names = "PersonID"),
              read.table("test/X_test.txt", sep="", header=FALSE, col.names = headerV),
              read.table("test/Y_test.txt", col.names = "ActivityID"))

trainTb<-cbind(read.table("train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE, col.names = "PersonID"),
              read.table("train/X_train.txt", sep="", header=FALSE, col.names = headerV),
              read.table("train/Y_train.txt", col.names = "ActivityID"))

## Step 1 (merge data sets)
mainTb<-rbind(trainTb,testTb)

## Step 2 (extract columns with means and SDs)
newColV<-sort(c(grep("mean()",headerV,fixed = TRUE),grep("-std()",headerV)))
mainTb<-mainTb[,c(1,newColV+1,length(mainTb))] # 'newColV adds 1 due to PersonID existence; also PersonID and ACtivityID are preserved

## Step 3 (insert descriptive activity names)
for(i in 1:length(actionV[,2])){s<-actionV[i,2];
      s<-paste(substr(s,1,1),tolower(substr(s,2,100)),sep="");
      actionV[i,2]<-gsub(pattern="_", replacement = " ", s)}
mainTb<-inner_join(mainTb,actionV)

## Step 4 (label the dataset with descriptive names)
headerV<-headerV[newColV]
headerV<-gsub(pattern = "Acc", replacement = "Accelerom", headerV)
headerV<-gsub(pattern = "Gyro", replacement = "Gyroscope", headerV)
headerV<-gsub(pattern = "Mag", replacement = "Magnitude", headerV)
headerV<-gsub(pattern = "tBody", replacement = "time.Body", headerV)
headerV<-gsub(pattern = "fBody", replacement = "freq.Body", headerV)
headerV<-gsub(pattern = "BodyBody", replacement = "Body", headerV)
headerV<-gsub(pattern = "-X", replacement = ".X-axis", headerV)
headerV<-gsub(pattern = "-Y", replacement = ".Y-axis", headerV)
headerV<-gsub(pattern = "-Z", replacement = ".Z-axis", headerV)
colV<-grep("-mean()",headerV,fixed = TRUE)
headerV[colV]<-paste(gsub(pattern="-mean()", replacement = "       ", headerV[colV], fixed = TRUE),".MeanValue")
colV<-grep("-std()",headerV,fixed = TRUE)
headerV[colV]<-paste(gsub(pattern="-std()", replacement = "      ", headerV[colV], fixed = TRUE),".StandardDeviation")
headerV<-gsub(pattern=" ", replacement = "", headerV, fixed = TRUE)
headerV<-c("PersonID",headerV,"ActivityID","ActivityShortName")
colnames(mainTb)<-headerV

nc<-ncol(mainTb)
mainTb<-mainTb[,c(1,nc-1,nc,2:(nc-2))]
headerV<-colnames(mainTb)

## Step 5 (create new, tidy dataset with average value for each subject&activity)
tidyDataset<-data.frame(stringsAsFactors = FALSE)
for(i in headerV) tidyDataset[[i]]<-as.numeric()

tidyCnt<-1
i<-1
j<-1
for(i in 1:30) {
  for(j in 1:6) {
    subTb<-mainTb[mainTb$PersonID==i & mainTb$ActivityID==j,]
    if(is.null(subTb)) next()
    tidyDataset[tidyCnt,1:3]<-subTb[1,1:3]
    tidyDataset[tidyCnt,4:nc]<-sapply(subTb[,4:nc],mean)
    tidyCnt<-tidyCnt+1
  }
}
rownames(tidyDataset)<-1:nrow(tidyDataset)

## Aftermath
write.table(tidyDataset,file="tidyDataset.csv",quote=FALSE,row.names=FALSE,sep = ";")
