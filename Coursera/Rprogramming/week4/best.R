## Script for week 4 of the R programming course
best  <- function(state, outcome) {
    ## Reads outcome data
    data <- read.csv(directory1, colClasses = "character", na.strings = "Not Available")[c(2,7,11,17,23)];
    
    ## Checks that state and outcome are valid
    if(is.na(match(state, unique(data[, 2])))) {
        stop("invalid state");
    } else if(is.na(match(outcome, c("heart attack", "heart failure", "pneumonia")))) {
        stop("invalid outcome");
    } else {
        ## Return hospital name in that state with lowest 30-day death rate
        s <- split(data, data[, 2]);
        tmp <- s[[state]];
        tmp[3] <- as.numeric(tmp[,3]);
        tmp[4] <- as.numeric(tmp[,4]);
        tmp[5] <- as.numeric(tmp[,5]);
        good <- complete.cases(tmp);
        tmp <- tmp[good,];
        colnames(tmp) <- c("Hospital.Name", "State", "heart attack", "heart failure", "pneumonia");
        tmp <- tmp[order(tmp[, outcome]),];
        return(tmp);
        #return(tmp[1, 1]);
    }
}