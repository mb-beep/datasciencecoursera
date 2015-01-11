# Script for completing project 2 of the Coursera
#  'Exploratory Data Analysis' course.
# Plots the needed 'plot5.png'

# Download if not done already and extract
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip";

if(!file.exists("./data/summarySCC_PM25.rds") || !file.exists("./data/Source_Classification_Code.rds")) {
    download.file(url, destfile = "./data/NEI_data.zip");
    unzip("./data/NEI_data.zip", exdir = "./data");
    file.remove("./data/NEI_data.zip");
}

# Read in extracted data using 'readRDS()' function.
# Modify variable names for easy access and merge.
NEI <- readRDS("./data/summarySCC_PM25.rds");
SCC <- readRDS("./data/Source_Classification_Code.rds");
names(NEI) <- tolower(names(NEI));
names(SCC) <- tolower(names(SCC));

# Get indices of emissions from motor vehicle sources using grepl
#  and get (unique) names them.
ind <- grepl("mobile(.*)vehicles", SCC$ei.sector, ignore.case = T);
emissionSrcs <- as.character(unique(SCC[ind, "ei.sector"]));
emissionSrcs;

# Use individual names of motor vehicle emissions (Gasoline, Diesel (Light/Heavy) Duty Vehicles)
#  to get 'SCC' values in 'SCC' data set. Use this values to get indices in 'NEI' data set and extract data.
# Lastly, summarize data using 'ddply'.
# Extract heavy diesel
hDiesel <- as.character(SCC[SCC$ei.sector == emissionSrcs[4], "scc"]);
hDTmp <- NEI[NEI$scc %in% hDiesel,];
heavyDiesel <- ddply(hDTmp, .(year), function(x) sum(x$emissions));
names(heavyDiesel) <- c("year", "emissions");
# Extract light diesel
lDiesel <- as.character(SCC[SCC$ei.sector == emissionSrcs[3], "scc"]);
lDTmp <- NEI[NEI$scc %in% lDiesel,];
lightDiesel <- ddply(lDTmp, .(year), function(x) sum(x$emissions));
names(lightDiesel) <- c("year", "emissions");
# Extract heavy gasoline
hGasoline <- as.character(SCC[SCC$ei.sector == emissionSrcs[2], "scc"]);
hGTmp <- NEI[NEI$scc %in% hGasoline,];
heavyGasoline <- ddply(hGTmp, .(year), function(x) sum(x$emissions));
names(heavyGasoline) <- c("year", "emissions");
# Extract light gasoline
lGasoline <- as.character(SCC[SCC$ei.sector == emissionSrcs[1], "scc"]);
lGTmp <- NEI[NEI$scc %in% lGasoline,];
lightGasoline <- ddply(lGTmp, .(year), function(x) sum(x$emissions));
names(lightGasoline) <- c("year", "emissions");

# Recombine individual sources
dfList <- list(lightDiesel, heavyDiesel, lightGasoline, heavyGasoline);
# Melt to reorder to a new 'data.frame' for easy plotting
meltSrcs <- melt(dfList, id = "year");
# 'dcast' to order appropriately
castSrcs <- dcast(meltSrcs, year ~ L1);
# Rename properly
names(castSrcs) <- c("year", "lightDiesel", "heavyDiesel", "lightGasoline", "heavyGasoline");