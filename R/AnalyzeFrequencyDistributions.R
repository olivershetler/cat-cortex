neuron_names = c("n00","n02","n04","n08","n10","n18","n23","n25","n26","n27")

library(tidyverse)
getParentDirectory =  function()
{
  this_file = commandArgs() %>% 
    tibble::enframe(name = NULL) %>%
    tidyr::separate(col=value, into=c("key", "value"), sep="=", fill='right') %>%
    dplyr::filter(key == "--file") %>%
    dplyr::pull(value)
  if (length(this_file)==0)
  {
    this_file = rstudioapi::getSourceEditorContext()$path
  }
  return(dirname(dirname(this_file)))
}

# Name the current file's directory string BASE_DIR
BASE_DIR = getParentDirectory()

CSV_DIR = paste(BASE_DIR, "/data/csv/")

# First, we load the frequency data frames for 1 millisecond.

db1ms_dir = paste(CSV_DIR, "drifting_bars1ms.csv", sep="")
db1ms = read.csv(db1ms_dir,sep=",")[1:13000,3:12]

wn1ms_dir = paste(CSV_DIR, "white_noise1ms.csv", sep="")
wn1ms = read.csv(wn1ms_dir,sep=",")[1:13000,3:12]

nm1ms_dir = paste(CSV_DIR, "natural_movie1ms.csv", sep="")
nm1ms = read.csv(nm1ms_dir,sep=",")[1:13000,3:12]
length(db1ms$n00)

all_1ms = rbind(db1ms,wn1ms,nm1ms)

group = as.factor(c(rep("db",length(db1ms[,1])),
                    rep("wn",length(wn1ms[,1])),
                    rep("nm",length(nm1ms[,1]))))

all_1ms = cbind(all_1ms,group)

#par(mfrow=c(2,5))
qqnorm(all_1ms$n00)
qqline(all_1ms$n00)



### Predicting Stimulus just from frequency neural data

library(class)
y_knn = knn(train=all_1ms[,1:10],test=all_1ms[1:10],k=800,l=0,prob=TRUE,use.all=FALSE,cl=all_1ms$group)
CM_knn = xtabs(~ all_1ms$group + y_knn)
sum(diag(CM_knn))/sum(CM_knn)
CM_knn
length(y_knn)
length(all_1ms$group)



# First, we load the frequency data frames for 0.1 second.

db0.1s_dir = paste(CSV_DIR, "drifting_bars0.1s.csv", sep="")
db0.1s = na.omit(read.csv(db0.1s_dir,sep=",")[1:1300,3:12])

wn0.1s_dir = paste(CSV_DIR, "white_noise0.1s.csv", sep="")
wn0.1s = na.omit(read.csv(wn0.1s_dir,sep=",")[1:1300,3:12])

nm0.1s_dir =  paste(CSV_DIR, "natural_movie0.1s.csv", sep="")
nm0.1s = na.omit(read.csv(nm0.1s_dir,sep=",")[1:1300,3:12])

length(wn0.1s$n00)

all_0.1s = rbind(db0.1s,wn0.1s,nm0.1s)

group = as.factor(c(rep("db",length(db0.1s[,1])),
                    rep("wn",length(wn0.1s[,1])),
                    rep("nm",length(nm0.1s[,1]))))

all_0.1s = cbind(all_0.1s,group)

length(all_0.1s)

par(mfrow=c(3,4))
for (i in seq(10)){
  qqnorm(all_0.1s[,i], main = paste("Neuron ",neuron_names[i]))
  qqline(all_0.1s[,i])
}

par(mfrow=c(3,4))
for (i in seq(10)){
  qqnorm(log(all_0.1s[,i]+0.5), main = paste("Neuron ",neuron_names[i]))
  qqline(log(all_0.1s[,i]+0.5))
}

qqnorm(log(all_0.1s$n02+0.5))
qqline(log(all_0.1s$n02+0.5))

hist(log(log(all_0.1s$n00+0.5)+0.5))

### Predicting Stimulus just from frequency neural data

library(nnet)
multinom = multinom(all_0.1s$group ~ ., data=log(all_0.1s[,1:10]+0.5))
CM_multinom = xtabs(~ predict(multinom) + all_0.1s$group)
sum(diag(CM_multinom))/sum(CM_multinom)
caret::confusionMatrix(CM_multinom)

library(MASS)
lda = lda(all_0.1s$group ~ ., data=log(all_0.1s[,1:10]+0.5))
CM_lda = xtabs(~ predict(lda)$class + all_0.1s$group)
sum(diag(CM_lda))/sum(CM_lda)
caret::confusionMatrix(CM_lda)

qda = qda(all_0.1s$group ~ ., data=log(all_0.1s[,1:10]+0.5))
CM_qda = xtabs(~ predict(qda)$class + all_0.1s$group)
sum(diag(CM_qda))/sum(CM_qda)
caret::confusionMatrix(CM_qda)

library(class)
y_knn = knn(train=all_0.1s[1:10],test=all_0.1s[1:10],k=1,l=0,prob=FALSE,use.all=TRUE,cl=all_0.1s$group)
CM_knn = xtabs(~ all_0.1s$group + y_knn)
sum(diag(CM_knn))/sum(CM_knn)
CM_knn
caret::confusionMatrix(CM_knn)

library(heplots)
boxM(all_0.1s[1:10],all_0.1s$group)



# First, we load the frequency data frames for 1 second.

db1s_dir = paste(CSV_DIR, "drifting_bars1s.csv", sep="")
db1s = read.csv(db1s_dir,sep=",")[1:130,3:12]

wn1s_dir = paste(CSV_DIR, "white_noise1s.csv", sep="")
wn1s = read.csv(wn1s_dir,sep=",")[1:130,3:12]

nm1s_dir = paste(CSV_DIR, "natural_movie1s.csv", sep="")
nm1s = read.csv(nm1s_dir,sep=",")[1:130,3:12]

all_1s = rbind(db1s,wn1s,nm1s)

length(wn1s$n00)

group = as.factor(c(rep("db",length(db1s[,1])),
                    rep("wn",length(wn1s[,1])),
                    rep("nm",length(nm1s[,1]))))

all_1s = cbind(all_1s,group)

length(all_1s)


par(mfrow=c(1,3),mai=c(.6,.6,1.5,.6))
hist(log(db1s$n00),breaks=75, main = "Neuron-00, Drifing Bars",xlab="Hz")
hist(log(wn1s$n00),breaks=100, main = "Neuron-00, White Noise",xlab="Hz")
mtext("Firing frequency distributions for three stimulus groups",
      side=3,line=10)
hist(log(nm1s$n00),breaks=100, main = "Neuron-00, Natural Movie",xlab="Hz")

par(mfrow=c(3,4))
for (i in seq(10)){
  qqnorm(all_1s[,i], main = paste("Neuron ",neuron_names[i]))
  qqline(all_1s[,i])
}

par(mfrow=c(3,4))
for (i in seq(10)){
  qqnorm(log(all_1s[,i]+0.5), main = paste("Neuron ",neuron_names[i]))
  qqline(log(all_1s[,i]+0.5))
}



### Predicting Stimulus just from frequency neural data

library(nnet)
multinom = multinom(all_1s$group ~ ., data=log(all_1s[,1:10]+0.5))
CM_multinom = xtabs(~ predict(multinom) + all_1s$group)
sum(diag(CM_multinom))/sum(CM_multinom)
caret::confusionMatrix(CM_multinom)

library(MASS)
lda = lda(all_1s$group ~ ., data=log(all_1s[,1:10]+0.5))
CM_lda = xtabs(~ predict(lda)$class + all_1s$group)
sum(diag(CM_lda))/sum(CM_lda)
caret::confusionMatrix(CM_lda)

qda = qda(all_1s$group ~ ., data=log(all_1s[,1:10]+0.5))
CM_qda = xtabs(~ predict(qda)$class + all_1s$group)
sum(diag(CM_qda))/sum(CM_qda)
caret::confusionMatrix(CM_qda)

library(class)
y_knn = knn(train=all_1s[1:10],test=all_1s[1:10],k=,l=0,prob=FALSE,use.all=TRUE,cl=all_1s$group)
CM_knn = xtabs(~ all_1s$group + y_knn)
sum(diag(CM_knn))/sum(CM_knn)
CM_knn
caret::confusionMatrix(CM_knn)


# First, we load the frequency data frames for 10 seconds.

db10s_dir = paste(CSV_DIR, "drifting_bars10s.csv", sep="")
db10s = read.csv(db10s_dir,sep=",")[1:13,3:12]

wn10s_dir = paste(CSV_DIR, "white_noise10s.csv", sep="")
wn10s = read.csv(wn10s_dir,sep=",")[1:13,3:12]

nm10s_dir = paste(CSV_DIR, "natural_movie10s.csv", sep="")
nm10s = read.csv(nm10s_dir,sep=",")[1:13,3:12]

all_10s = rbind(db10s,wn10s,nm10s)

group = as.factor(c(rep("db",length(db10s[,1])),
                    rep("wn",length(wn10s[,1])),
                    rep("nm",length(nm10s[,1]))))

all_10s = cbind(all_10s,group)

length(wn10s$n00)


### Predicting Stimulus just from frequency neural data

library(nnet)
multinom = multinom(group ~ ., data=all_10s)
CM_multinom = xtabs(~ predict(multinom) + all_10s$group)
sum(diag(CM_multinom))/sum(CM_multinom)
caret::confusionMatrix(CM_multinom)

library(MASS)
lda = lda(group ~ ., data=all_10s)
CM_lda = xtabs(~ predict(lda)$class + all_10s$group)
sum(diag(CM_lda))/sum(CM_lda)
caret::confusionMatrix(CM_lda)

qda = qda(group ~ ., data=all_10s)
CM_qda = xtabs(~ predict(qda)$class + all_10s$group)
sum(diag(CM_qda))/sum(CM_qda)
caret::confusionMatrix(CM_qda)


library(class)
y_knn = knn(train=all_10s[1:10],test=all_10s[1:10],k=,l=0,prob=FALSE,use.all=TRUE,cl=all_10s$group)
CM_knn = xtabs(~ all_10s$group + y_knn)
sum(diag(CM_knn))/sum(CM_knn)
CM_knn
caret::confusionMatrix(CM_knn)






