rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv(directory1, colClasses = "character", na.strings = "Not Available")[c(2,7,11,17,23)];
    ## Check that outcome is valid
    #if(is.na(match(state, unique(data[, 2])))) {
        #stop("invalid state");
    #} else 
    if(is.na(match(outcome, c("heart attack", "heart failure", "pneumonia")))) {
        stop("invalid outcome");
    } else {
    ## For each state, find the hospital of the given rank
        state <- unique(data[, 2]);
        s <- split(data, data[, 2]);
        rank <- data.frame(hospital = 1, state = 1);
        i = 1;
        for(i in 1:length(state)) {
            tmp <- s[[state[i]]];
            tmp[3] <- as.numeric(tmp[,3]);
            tmp[4] <- as.numeric(tmp[,4]);
            tmp[5] <- as.numeric(tmp[,5]);
            #good <- complete.cases(tmp);
            #tmp <- tmp[good,];
            colnames(tmp) <- c("Hospital.Name", "State", "heart attack", "heart failure", "pneumonia");
            tmp <- tmp[order(tmp[, outcome], tmp[, 1]),];
            if(num == "best") {
                rank[i, 1] = as.character(tmp[1, 1]);
                rank[i, 2] = as.character(tmp[1, 2]);
            } else if(num == "worst") {
                rank[i, 1] = as.character(tmp[dim(tmp)[1], 1]);
                rank[i, 2] = as.character(tmp[dim(tmp)[1], 2]);
            } else if(num <= dim(tmp)[1]) {
                rank[i, 1] = as.character(tmp[num, 1]);
                rank[i, 2] = as.character(tmp[num, 2]);
            } else {
                rank[i, 1] = NA;
                rank[i, 2] = as.character(state[i]);
            }
        }
    }
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    return(rank);
}