# Script for completing project 2 of the Coursera
#  'Exploratory Data Analysis' course.
# Plots the needed 'plot4.png'

# Download if not done already and extract
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip";

if(!file.exists("./data/summarySCC_PM25.rds") || !file.exists("./data/Source_Classification_Code.rds")) {
    download.file(url, destfile = "./data/NEI_data.zip");
    unzip("./data/NEI_data.zip", exdir = "./data");
    file.remove("./data/NEI_data.zip");
}

# Read in extracted data using 'readRDS()' function.
# Modify variable names for easy access.
NEI <- readRDS("./data/summarySCC_PM25.rds");
SCC <- readRDS("./data/Source_Classification_Code.rds");
names(NEI) <- tolower(names(NEI));
names(SCC) <- tolower(names(SCC));

# Get indices of coal combustions-related resources using grepl
#  and get (unique) names of sectors
ind <- grepl("fuel comb(.*)coal", SCC$ei.sector, ignore.case = T);
emissionSrcs <- as.character(unique(SCC[ind, "ei.sector"]));

# Use individual names of coal combustion resources (industrial, institutional and electrical)
#  to get 'SCC' values in 'SCC' data set. Use this values to get indices in 'NEI' data set and extract data.
# Lastly, summarize data using 'ddply'.
inst <- as.character(SCC[SCC$ei.sector == emissionSrcs[3], "scc"]);
instTmp <- NEI[NEI$scc %in% inst,];
inst <- ddply(instTmp, .(year), function(x) sum(x$emissions));
names(inst) <- c("year", "emissions");
# Extract industrial emission sources
ind <- as.character(SCC[SCC$ei.sector == emissionSrcs[2], "scc"]);
indTmp <- NEI[NEI$scc %in% ind,];
ind <- ddply(indTmp, .(year), function(x) sum(x$emissions));
names(ind) <- c("year", "emissions");
# Extract electric sources
elec <- as.character(SCC[SCC$ei.sector == emissionSrcs[1], "scc"]);
elecTmp <- NEI[NEI$scc %in% elec,];
elec <- ddply(elecTmp, .(year), function(x) sum(x$emissions));
names(elec) <- c("year", "emissions");

# Recombine individual sources
dfList <- list(inst, ind, elec);
# Melt to reorder to a new 'data.frame' for easy plotting
meltSrcs <- melt(dfList, id = "year");
# 'dcast' to order appropriately
castSrcs <- dcast(meltSrcs, year ~ L1);
# Rename properly
names(castSrcs) <- c("year", "institutional", "industrial", "electrical");

# Plot using base system
png("./figures/plot4.png", bg = "transparent");
matplot(castSrcs$year, castSrcs[,2:4], type = "l", lty = 1, lwd = 2, xlab = "Year", ylab = "Total emissions in tons");
legend("topright", legend = c("Institutional", "Industrial", "Electrical"), col = c("black", "red", "green"), lty = "solid");
dev.off();