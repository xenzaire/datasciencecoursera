#Part 3 - Write a Function that Takes the Directory and a Threshold for Complete Cases and Calculates the Correlation Between Sulfate and Nitrate for Monitor Locations Where the Number of Completely Observed Cases is Greater than the Threshold
corr <- function(directory, threshold = 0) {
  setwd(directory)
  id <- 1:length(dir())
  report <- c()
  for (i in id) {
    filename <- paste(sprintf("%03d", i), ".csv", sep = "") 
    df <- read.csv(filename)
    df <- df[complete.cases(df),]
    if (nrow(df) > threshold) {
      report <- append(report, cor(df$sulfate, df$nitrate))
    }
  }
  report
}