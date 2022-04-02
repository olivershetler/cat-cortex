"""
This code is used to generate discrete firing frequency data
for buckets at various time-scales.
"""

# Define the bucket sizes corresponding to each time-scale

ms0.1 = 100
ms1 = 1000
s0.01 = 10000
s0.1 = 100000
s1 = 1000000
s10 = 10000000
min1 = 60000000


# Define a function to get the current directory of this file
library(tidyverse)
getCurrentFileLocation =  function()
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
  return(dirname(this_file))
}

# Name the current file's directory string BASE_DIR
BASE_DIR = dirname(getCurrentFileLocation())

# Append the local spike data directory to the base directory 
# for each experimental condition
dir_db = paste(BASE_DIR, "/crcns_pvc3_cat_recordings/drifting_bar/spike_data/", sep="")
dir_wn = paste(BASE_DIR, "/crcns_pvc3_cat_recordings/white_noise/spike_data/", sep="")
dir_nm = paste(BASE_DIR, "/crcns_pvc3_cat_recordings/natural_movie/spike_data/", sep="")

# Append the local stimulus data directory to the base directory
# for each experimental condition
path_stim_db = paste(BASE_DIR, "/crcns_pvc3_cat_recordings/drifting_bar/stimulus_data/drifting_bar.din", sep="")
path_stim_nm = paste(BASE_DIR, "l/crcns_pvc3_cat_recordings/natural_movie/stimulus_data/ns2-64p-50h-2m-mn125-ct045.din", sep="")
path_stim_wn = paste(BASE_DIR, "/crcns_pvc3_cat_recordings/white_noise/stimulus_data/wn2-64p-50h-2m-mn125-ct045.din", sep="")

# Concatinate the time-scales into a vector
time_scales = c(ms0.1,ms1,s0.01,s0.1,s1,s10,min1)
# Create a corresponding vector with string names of each time-scale
name_scales = c("0.1ms","1ms","0.01s","0.1s","1s","10s","1min")
# Create a vector with string-names for each experimental condition
group_names = c("drifting_bars","white_noise","natural_movie")
# Create a vector with the spike data directory strings
dir_groups = c(dir_db,dir_wn,dir_nm)
# Create a vector with the file-names for each neuron recorded
# in any of the spike data directories
spike_file_names = c("t00.dat", "t02.dat", "t04.dat", "t08.dat",
"t10.dat", "t18.dat", "t23.dat", "t25.dat", "t26.dat", "t27.dat")
# Create a vector with the stimulus data directory strings
path_stim_groups = c(path_stim_db,path_stim_nm,path_stim_wn)


# TO DO:
# - [ ]  add a test condtion that verifies the length of dir_groups and group_names is the same.

for (g in 1:length(dir_groups)){ # g is the index for groups
    ##########
    dir = dir_groups[g] # enter the desired directory
    ##########
    path = path_stim_groups[g] # 
    ##########
    group = group_names[g] # used for writing .csv files at the end
  for (s in 1:length(time_scales)){ # s for time-scales

    # Read the spike binary files containing time stamps of each neural spike
    
    # directories for the different groups of neural spike data
    

    
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
    
    ##########
    
    
    k = time_scales[s] # define k as the time-scale
    ##########
    
    
    t00 = (readBin(f00,"integer",n=100000,size=8)/k)+1
    t02 = (readBin(f02,"integer",n=100000,size=8)/k)+1
    t04 = (readBin(f04,"integer",n=100000,size=8)/k)+1
    t08 = (readBin(f08,"integer",n=100000,size=8)/k)+1
    t10 = (readBin(f10,"integer",n=100000,size=8)/k)+1
    t18 = (readBin(f18,"integer",n=100000,size=8)/k)+1
    t23 = (readBin(f23,"integer",n=100000,size=8)/k)+1
    t25 = (readBin(f25,"integer",n=100000,size=8)/k)+1
    t26 = (readBin(f26,"integer",n=100000,size=8)/k)+1
    t27 = (readBin(f27,"integer",n=100000,size=8)/k)+1
    
    # paths to the different neural data files
    
    stim_f = file(path,"rb")
    stim_df = matrix(readBin(stim_f,"integer",n=10000000,size=8),ncol=2,byrow=TRUE)
    stim_time = (stim_df[,1]/k)
    stim_type = stim_df[,2]
    
    
    # Find the last record of activity for the drifting bars data
    last_times = c(t00[length(t00)],
                   t02[length(t02)],
                   t04[length(t04)],
                   t08[length(t08)],
                   t10[length(t10)],
                   t18[length(t18)],
                   t23[length(t23)],
                   t25[length(t25)],
                   t26[length(t26)],
                   t27[length(t27)],
                   stim_time[length(stim_time)])
    
    
    
    # make zero vectors of the length of the drifting bars data
    zeros = rep(0,max(last_times))
    n00 = zeros
    n02 = zeros
    n04 = zeros
    n08 = zeros
    n10 = zeros
    n18 = zeros
    n23 = zeros
    n25 = zeros
    n26 = zeros
    n27 = zeros
    stim = zeros
    
    
    
    # count the number of spikes in each bucket in the ...
    
    for (ts in t00) {
      n00[ts] = n00[ts]+1
    }
    for (ts in t02) {
      n02[ts] = n02[ts]+1
    }
    for (ts in t04) {
      n04[ts] = n04[ts]+1
    }
    for (ts in t08) {
      n08[ts] = n08[ts]+1
    }
    for (ts in t10) {
      n10[ts] = n10[ts]+1
    }
    for (ts in t18) {
      n18[ts] = n18[ts]+1
    }
    for (ts in t23) {
      n23[ts] = n23[ts]+1
    }
    for (ts in t25) {
      n25[ts] = n25[ts]+1
    }
    for (ts in t26) {
      n26[ts] = n26[ts]+1
    }
    for (ts in t27) {
      n27[ts] = n27[ts]+1
    }
    stim[1:stim_time[1]-1] = stim_type[1]
    for (i in seq(1,length(stim_time)-1)) {
      ts0 = stim_time[i]
      ts1 = stim_time[i+1]-1
      stim[ts0:ts1] = stim_type[i]
    }
    
    
    # binds the data columns into a data frame
    
    df = data.frame(cbind(stim,n00,n02,n04,n08,n10,n18,n23,n25,n26,n27))
    spikes = df[,2:10]
    global = rowSums(spikes)
    df = cbind(df,global)
    
    
    
    # The row names are given in milliseconds
    rownames(spikes) = (k/1000)*seq(length(n00))
    rownames(df) = (k/1000)*seq(length(n00))
    
    
    # Write a .csv file with the data frame
    scale = name_scales[s] # assign the name of the scale
    write_dir = paste(BASE_DIR, "/data/csv/", sep="")
    write.csv(df,paste(write_dir,group,scale,".csv",sep=""))
    print(paste("group: ",group))
    print(paste("scale: ",scale))
  }
}



