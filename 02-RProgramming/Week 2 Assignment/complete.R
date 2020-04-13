#Set Working Directory
specdata <- "D:/Data Science/Coursera/Data Science Specialization/R Programming Assignment/Week 2 Assignment/specdata"

#Part 2 - Directory that Reports the Number of Completely Observed Cases
complete <- function(directory, id = 1:332) {
  setwd(directory) #Set the directory of where the csv files were located
  report <- data.frame()
  for (i in id) {
    filename <- paste(sprintf("%03d", i), ".csv", sep = "")
    df <- read.csv(filename)
    report_temp <- data.frame("id" = i, "nobs" = sum(complete.cases(df)))
    report <- rbind(report, report_temp)
  }
  report
}