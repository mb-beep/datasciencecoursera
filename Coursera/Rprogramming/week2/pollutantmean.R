pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    files <- list.files(path = directory, pattern = ".csv");
    tmp <- data.frame();
    meanTemp <- numeric();
    mean <- numeric();
    for(i in id[1]:id[length(id)]) {
        tmp <- read.csv(paste(directory, "\\", files[i], sep = ""), header = T);
        meanTemp <- tmp[, pollutant];
        mean <- c(mean, meanTemp);
        #meanTemp[, i] <- tmp[, pollutant]
        #meanTmp <- tmp[, pollutant]
    }
    #meanOverall <- mean(meanTmp[], na.rm = T)
    #return(meanOverall)
    mean <- mean(mean, na.rm = T);
    return(round(mean, digits = 3));
}