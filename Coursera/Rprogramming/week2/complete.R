complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    files <- list.files(path = directory, pattern = ".csv");
    i = 1L;
    good <- logical();
    sumGood <- numeric();
    while(is.na(id[i]) != T) {
        tmp <- read.csv(paste(directory, "\\", files[id[i]], sep = ""), header = T);
        #good <- complete.cases(tmp);
        sumGood[i] <- sum(complete.cases(tmp));
        i = i + 1;
    }
    nobs <- data.frame(id, sumGood);
    names(nobs) <- c("id", "nobs");
    return(nobs);
}