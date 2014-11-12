corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    files <- list.files(path = directory, pattern = ".csv");
    tmp <- data.frame();
    corVec <- numeric();
    j = 1L;
    for(i in 1:length(files)) {
        tmp <- read.csv(paste(directory, "\\", files[i], sep = ""), header = T);
        good <- complete.cases(tmp);
        if(sum(good) > threshold) {
            corVec[j] <- cor(tmp[good, "sulfate"], tmp[good, "nitrate"], method = c("pearson"));
            j = j + 1;
        }
    }
    return(corVec);
}