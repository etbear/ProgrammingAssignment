run_analysis<-function() {
  ##Read test data (X_test), test activity (y_test), test subject (subject_test)
  ##Read training data (X_train), training activity (y_train), training subject (subject_train)
  ##Read activity label and features
  xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
  ytest<-read.table("UCI HAR Dataset/test/y_test.txt")
  stest<-read.table("UCI HAR Dataset/test/subject_test.txt")
  xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
  ytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
  strain<-read.table("UCI HAR Dataset/train/subject_train.txt")
  ac<-read.table("UCI HAR Dataset/activity_labels.txt")
  f<-read.table("UCI HAR Dataset/features.txt")
  
  ##merge test and training data
  x<-rbind(xtest,xtrain)
  y<-rbind(ytest,ytrain)
  s<-rbind(stest,strain)
  
  ##name the measurements based on explanation in feature and extract only mean and std
  names(x)<-f[,2]
  x<-x[,grep("mean\\(\\)|std\\(\\)",f[,2])]
  
  #merge activity and subject into main data
  x["subject"]<-s
  y<-merge(y,ac,"V1")
  x["activity"]<-y[,2]
  
  #compute mean by group (subject&activity)
  t<-aggregate(x[,1:66],by=list(x$activity, x$subject),mean)
  t
}