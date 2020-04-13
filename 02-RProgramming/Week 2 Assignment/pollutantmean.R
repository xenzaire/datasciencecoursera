#Set Working Directory
specdata <- "D:/Data Science/Coursera/Data Science Specialization/R Programming Assignment/Week 2 Assignment/specdata"


#Part 1 - Write Function for Pollutant Mean
pollutantmean <- function(directory, pollutant = "sulfate", id = 1:332) {
  setwd(directory) #Set the directory of where the csv files were located
  df <- data.frame() #Create empty dataframe
  for (i in id) { #Read and combine all files
    filename <- paste(sprintf("%03d", i), ".csv", sep = "")
    df_temp <- read.csv(filename)
    df <- rbind(df, df_temp)
  }
  mean(df[[pollutant]], na.rm = TRUE) #Calculate the mean of the polluatants across all observations
}
