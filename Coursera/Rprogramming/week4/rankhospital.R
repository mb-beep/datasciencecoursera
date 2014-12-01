rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv(directory1, colClasses = "character", na.strings = "Not Available")[c(2,7,11,17,23)];
    
    ## Check that state and outcome are valid
    if(is.na(match(state, unique(data[, 2])))) {
        stop("invalid state");
    } else if(is.na(match(outcome, c("heart attack", "heart failure", "pneumonia")))) {
        stop("invalid outcome");
    } else {
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        s <- split(data, data[, 2]);
        tmp <- s[[state]];
        tmp[3] <- as.numeric(tmp[,3]);
        tmp[4] <- as.numeric(tmp[,4]);
        tmp[5] <- as.numeric(tmp[,5]);
        good <- complete.cases(tmp);
        tmp <- tmp[good,];
        colnames(tmp) <- c("Hospital.Name", "State", "heart attack", "heart failure", "pneumonia");
        tmp <- tmp[order(tmp[, outcome], tmp[, 1]),];
        if(num == "best") {
            return(tmp[1, 1]);
        } else if(num == "worst") {
            return(tmp[dim(tmp)[1], 1]);
        } else if(num <= dim(tmp)[1]) {
            return(tmp[num, 1]);
        } else {
            return(NA);
        }
    }
}