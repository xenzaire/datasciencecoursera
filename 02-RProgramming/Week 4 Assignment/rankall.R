####Function takes 2 arguments, outcome and hospital rank (num).
####Reads outcome-of-care-measures.csv file and returns a 2-col data frame
####containing the hospital in each state that has the ranking specified in num.
####Hospital that do not have the data on a particular outcome would be excluded.

rankall <- function(outcome, num = "best") {
  #Read data and retain only relevant columns
  df <- read.csv("D:/Data Science/Coursera/Data Science Specialization/R Programming Assignment/datasciencecoursera/02-RProgramming/Week 4 Assignment/Data/outcome-of-care-measures.csv", colClasses = "character")
  df <- df[, c(2, 7, 11, 17, 23)]
  df[, 3:5] <- sapply(df[, 3:5], as.numeric)
  #Test outcome validity and remove irrelevant data
  outcome_check <- c("heart attack", "heart failure", "pneumonia")
  if (!outcome %in% outcome_check) {
    stop("Invalid outcome")
  } else if (outcome == "heart attack") {
    df <- df[, -c(4, 5)]
  } else if (outcome == "heart failure") {
    df <- df[, -c(3, 5)]
  } else if (outcome == "pneumonia") {
    df <- df[, -c(3, 4)]
  }
  #Delete NAs
  df <- df[complete.cases(df),]
  #Sort by state, mortality and hospital name
  df <- df[order(df[,2], df[,3], df[,1]),]
  #Extract states
  states <- unique(df[,2])
  #Test num validity and determine results
  if (num == "best") {
    result <- t(sapply(split(df, df[,2]), function(x) x[1,c(1:2)]))
  } else if (num == "worst") {
    result <- t(sapply(split(df, df[,2]), function(x) tail(x, 1)))[, c(1:2)]
  } else if (num > 0) {
    result <- t(sapply(split(df, df[,2]), function(x) x[num,c(1:2)]))
  } else {
    stop("Invalid ranking")
  }
  result
}
