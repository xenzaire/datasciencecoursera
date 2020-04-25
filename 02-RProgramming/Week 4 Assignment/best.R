####Function that takes the state and outcome name and returns a character vector
#####with the name of the hospital with the lowest 30-day mortality rate for that
#####outcome name (heart attack, heart failure or pneumonia) in that state.
#####Hospitals without that particular outcome would be excluded.

####If there is a tie, then the hospital names should be sorted in alphabetical
####order and the first hospital in that set should be chosen.

best <- function (state = NULL, outcome = NULL) {
  #Load data and retain only relevant columns
  rates <- read.csv("D:/Data Science/Coursera/Data Science Specialization/R Programming Assignment/datasciencecoursera/02-RProgramming/Week 4 Assignment/Data/outcome-of-care-measures.csv", colClasses = "character")
  rates <- rates[,c(2, 7, 11, 17, 23)]
  rates[,3:5] <- sapply(rates[,3:5], as.numeric)
  #Check if state is valid
  if (is.null(state)) {
    stop("Must enter state")
  } else if (!state %in% rates[,2]) {
    stop("Must enter valid state")
  }
  #Retain only relevant state records
  rates <- rates[(rates[,2] == state),]
  #Check if outcome is valid
  check_outcome <- c("heart attack", "heart failure", "pneumonia")
  if (is.null(outcome)) {
    stop("Must enter outcome value")
  } else if (!outcome %in% check_outcome) {
    stop("Invalid outcome value")
  }
  #Delete irrelevant columns according to outcome required
  if (outcome == "heart attack") {
    rates <- rates[, -c(4, 5)]
  } else if (outcome == "heart failure") {
    rates <- rates[, -c(3, 5)]
  } else if (outcome == "pneumonia") {
    rates <- rates[, -c(3, 4)]
  }
  #Delete NAs
  rates <- rates[complete.cases(rates),]
  #Sort by mortality rates (ascending) and hospital name (ascending)
  rates <- rates[order(rates[,3], rates[,1]),]
  #Print the top result
  rates[1,1]
}
