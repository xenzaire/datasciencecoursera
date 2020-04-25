####Function that takes 3 arguments:
####1) state - state abbreviation
####2) outcome - outcome
####3) num - ranking of a hospital in that state
####The function reads outcome-of-care-measures.csv and returns a character
####vector with the name of the hospital that has the ranking specified
####The num  argument can take "best" and "worst" or an integer
####If the number is larger than the number of hospital in that state, return NA
####Hospital without information on that outcome would be excluded
####Ties are broken by alphabetical order of the hospital name

rankhospital <- function (state, outcome, num = "best") {
  #Read df and retain only relevant outcome
  df <- read.csv("D:/Data Science/Coursera/Data Science Specialization/R Programming Assignment/datasciencecoursera/02-RProgramming/Week 4 Assignment/Data/outcome-of-care-measures.csv", colClasses = "character")
  df <- df[c(2, 7, 11, 17, 23)]
  df[,3:5] <- sapply(df[,3:5], as.numeric)
  #Test state input is valid
  if (!state %in% unique(df[,2])) {
    stop("Please enter a valid state")
  }
  #Retain only information for relevant state
  df <- df[df[,2] == state,]
  #Test outcome input is valid
  check_outcome <- c("heart attack", "heart failure", "pneumonia")
  if (!outcome %in% check_outcome) {
    stop("Please enter a valid outcome")
  }
  #Retain only information for the relevant outcome
  if (outcome == "heart attack") {
    df <- df[, -c(4, 5)]
  } else if (outcome == "heart failure") {
    df <- df[, -c(3, 5)]
  } else if (outcome == "pneumonia") {
    df <- df[, -c (3, 4)]
  }
  #Delete NAs
  df <- df[complete.cases(df),]
  #Sort by mortality rate (ascending) and hospital name (ascending)
  df <- df[order(df[,3], df[,1]),]
  #Assign ranking
  Rank <- c(1:nrow(df))
  df <- cbind(df, Rank)
  #Test num input is valid and print out result
  if (num == "best") {
    result <- df[1, 1]
  } else if (num == "worst") {
    result <- df[nrow(df), 1]
  } else if (num > nrow(df)) {
    result <- NA
  } else if (num > 0 & num <= nrow(df)) {
    result <- df[num, 1]
  } else {
    stop("Please enter a valid rank")
  }
  result
}
