# function for finding the parent directory of this script
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

# function to compute inter-spike intervals

ISI = function(txx){
  isi = c()
  for (i in seq(length(txx))){
    isi = c(isi,txx[i+1]-txx[i])
  }
  return(isi)
}

# Read the spike binary files containing time stamps of each neural spike

# Name the current file's directory string BASE_DIR
BASE_DIR = getParentDirectory()

# directories for the different groups of neural spike data
dir_db = paste(BASE_DIR, "/data/original/drifting_bar/spike_data/" , sep="")
dir_wn = paste(BASE_DIR, "/data/original/white_noise/spike_data/", sep="")
dir_nm = paste(BASE_DIR, "/data/original/natural_movie/spike_data/", sep="")

##########
dir = dir_db # Currently working on drifting bar data
##########

f00 = file(paste(dir,"t00.dat",sep=""),"rb")
f02 = file(paste(dir,"t02.dat",sep=""),"rb")
f04 = file(paste(dir,"t04.dat",sep=""),"rb")
f08 = file(paste(dir,"t08.dat",sep=""),"rb")
f10 = file(paste(dir,"t10.dat",sep=""),"rb")
f18 = file(paste(dir,"t18.dat",sep=""),"rb")
f23 = file(paste(dir,"t23.dat",sep=""),"rb")
f25 = file(paste(dir,"t25.dat",sep=""),"rb")
f26 = file(paste(dir,"t26.dat",sep=""),"rb")
f27 = file(paste(dir,"t27.dat",sep=""),"rb")

# timestamps are measured in microseconds with 10 microsecond precision.


t00 = c(0,readBin(f00,"integer",n=100000,size=8))
t02 = c(0,readBin(f02,"integer",n=100000,size=8))
t04 = c(0,readBin(f04,"integer",n=100000,size=8))
t08 = c(0,readBin(f08,"integer",n=100000,size=8))
t10 = c(0,readBin(f10,"integer",n=100000,size=8))
t18 = c(0,readBin(f18,"integer",n=100000,size=8))
t23 = c(0,readBin(f23,"integer",n=100000,size=8))
t25 = c(0,readBin(f25,"integer",n=100000,size=8))
t26 = c(0,readBin(f26,"integer",n=100000,size=8))
t27 = c(0,readBin(f27,"integer",n=100000,size=8))



isi00_db = na.omit(ISI(t00))
isi02_db = na.omit(ISI(t02))
isi04_db = na.omit(ISI(t04))
isi08_db = na.omit(ISI(t08))
isi10_db = na.omit(ISI(t10))
isi18_db = na.omit(ISI(t18))
isi23_db = na.omit(ISI(t23))
isi25_db = na.omit(ISI(t25))
isi26_db = na.omit(ISI(t26))
isi27_db = na.omit(ISI(t27))

##########
dir = dir_wn # currently workin on white noise data
##########

f00 = file(paste(dir,"t00.dat",sep=""),"rb")
f02 = file(paste(dir,"t02.dat",sep=""),"rb")
f04 = file(paste(dir,"t04.dat",sep=""),"rb")
f08 = file(paste(dir,"t08.dat",sep=""),"rb")
f10 = file(paste(dir,"t10.dat",sep=""),"rb")
f18 = file(paste(dir,"t18.dat",sep=""),"rb")
f23 = file(paste(dir,"t23.dat",sep=""),"rb")
f25 = file(paste(dir,"t25.dat",sep=""),"rb")
f26 = file(paste(dir,"t26.dat",sep=""),"rb")
f27 = file(paste(dir,"t27.dat",sep=""),"rb")

# timestamps are measured in microseconds with 10 microsecond precision.


t00 = c(0,readBin(f00,"integer",n=100000,size=8))
t02 = c(0,readBin(f02,"integer",n=100000,size=8))
t04 = c(0,readBin(f04,"integer",n=100000,size=8))
t08 = c(0,readBin(f08,"integer",n=100000,size=8))
t10 = c(0,readBin(f10,"integer",n=100000,size=8))
t18 = c(0,readBin(f18,"integer",n=100000,size=8))
t23 = c(0,readBin(f23,"integer",n=100000,size=8))
t25 = c(0,readBin(f25,"integer",n=100000,size=8))
t26 = c(0,readBin(f26,"integer",n=100000,size=8))
t27 = c(0,readBin(f27,"integer",n=100000,size=8))



isi00_wn = na.omit(ISI(t00))
isi02_wn = na.omit(ISI(t02))
isi04_wn = na.omit(ISI(t04))
isi08_wn = na.omit(ISI(t08))
isi10_wn = na.omit(ISI(t10))
isi18_wn = na.omit(ISI(t18))
isi23_wn = na.omit(ISI(t23))
isi25_wn = na.omit(ISI(t25))
isi26_wn = na.omit(ISI(t26))
isi27_wn = na.omit(ISI(t27))


##########
dir = dir_nm # currently working on natural movie data
##########

f00 = file(paste(dir,"t00.dat",sep=""),"rb")
f02 = file(paste(dir,"t02.dat",sep=""),"rb")
f04 = file(paste(dir,"t04.dat",sep=""),"rb")
f08 = file(paste(dir,"t08.dat",sep=""),"rb")
f10 = file(paste(dir,"t10.dat",sep=""),"rb")
f18 = file(paste(dir,"t18.dat",sep=""),"rb")
f23 = file(paste(dir,"t23.dat",sep=""),"rb")
f25 = file(paste(dir,"t25.dat",sep=""),"rb")
f26 = file(paste(dir,"t26.dat",sep=""),"rb")
f27 = file(paste(dir,"t27.dat",sep=""),"rb")

# timestamps are measured in microseconds with 10 microsecond precision.


t00 = c(0,readBin(f00,"integer",n=100000,size=8))
t02 = c(0,readBin(f02,"integer",n=100000,size=8))
t04 = c(0,readBin(f04,"integer",n=100000,size=8))
t08 = c(0,readBin(f08,"integer",n=100000,size=8))
t10 = c(0,readBin(f10,"integer",n=100000,size=8))
t18 = c(0,readBin(f18,"integer",n=100000,size=8))
t23 = c(0,readBin(f23,"integer",n=100000,size=8))
t25 = c(0,readBin(f25,"integer",n=100000,size=8))
t26 = c(0,readBin(f26,"integer",n=100000,size=8))
t27 = c(0,readBin(f27,"integer",n=100000,size=8))



isi00_nm = na.omit(ISI(t00))
isi02_nm = na.omit(ISI(t02))
isi04_nm = na.omit(ISI(t04))
isi08_nm = na.omit(ISI(t08))
isi10_nm = na.omit(ISI(t10))
isi18_nm = na.omit(ISI(t18))
isi23_nm = na.omit(ISI(t23))
isi25_nm = na.omit(ISI(t25))
isi26_nm = na.omit(ISI(t26))
isi27_nm = na.omit(ISI(t27))

###
# merge the isi distributions by neuron

isi00 = c(isi00_db,isi00_nm,isi00_wn)
isi02 = c(isi02_db,isi02_nm,isi02_wn)
isi04 = c(isi04_db,isi04_nm,isi04_wn)
isi08 = c(isi08_db,isi08_nm,isi08_wn)
isi10 = c(isi10_db,isi10_nm,isi10_wn)
isi18 = c(isi18_db,isi18_nm,isi18_wn)
isi23 = c(isi23_db,isi23_nm,isi23_wn)
isi25 = c(isi25_db,isi25_nm,isi25_wn)
isi25 = c(isi25_db,isi25_nm,isi25_wn)
isi26 = c(isi26_db,isi26_nm,isi26_wn)
isi27 = c(isi27_db,isi27_nm,isi27_wn)

#############################################

# Plot ISI distributions

par(mfrow=c(1,3),mai=c(.6,.6,1.5,.6))

hist(isi00_db,breaks=100, main = "Neuron-00, Drifing Bars",xlab="ISI distance")
hist(isi00_wn,breaks=100, main = "Neuron-00, White Noise",xlab="ISI distance")
mtext("Inter Spike Interval (ISI) distributions for three stimulus groups",
      side=3,line=10)
hist(isi00_nm,breaks=100, main = "Neuron-00, Natural Movie",xlab="ISI distance")



par(mfrow=c(1,3),mai=c(.6,.6,1.5,.6))
hist(isi00,breaks=100, main = "Neuron-00, All Groups",xlab="ISI distance")
hist(isi02,breaks=100, main = "Neuron-02, All Groups",xlab="ISI distance")
mtext("Inter Spike Interval (ISI) distributions for three stimulus groups",
      side=3,line=10)
hist(isi04,breaks=100, main = "Neuron-04, All Groups",xlab="ISI distance")
hist(isi08,breaks=100, main = "Neuron-08, All Groups",xlab="ISI distance")
hist(isi10,breaks=100, main = "Neuron-10, All Groups",xlab="ISI distance")
hist(isi18,breaks=100, main = "Neuron-18, All Groups",xlab="ISI distance")
hist(isi23,breaks=100, main = "Neuron-23, All Groups",xlab="ISI distance")
hist(isi25,breaks=100, main = "Neuron-25, All Groups",xlab="ISI distance")
hist(isi26,breaks=100, main = "Neuron-26, All Groups",xlab="ISI distance")
hist(isi27,breaks=100, main = "Neuron-27, All Groups",xlab="ISI distance")



Mdb = c(mean(isi00_db),mean(isi02_db),mean(isi04_db),mean(isi08_db),
        mean(isi10_db),mean(isi18_db),mean(isi23_db),mean(isi25_db),
        mean(isi26_db),mean(isi26_db))

Mwn = c(mean(isi00_wn),mean(isi02_wn),mean(isi04_wn),mean(isi08_wn),
        mean(isi10_wn),mean(isi18_wn),mean(isi23_wn),mean(isi25_wn),
        mean(isi26_wn),mean(isi26_wn))

Mnm = c(mean(isi00_nm),mean(isi02_nm),mean(isi04_nm),mean(isi08_nm),
        mean(isi10_nm),mean(isi18_nm),mean(isi23_nm),mean(isi25_nm),
        mean(isi26_nm),mean(isi26_nm))

M = cbind(Mdb,Mwn,Mnm)

rownames(M) = c("n00","n02","n04","n08","n10","n18","n23","n25","n26","n27")

# You can export the plot to a file using the RStudio interface.