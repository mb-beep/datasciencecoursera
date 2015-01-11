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
ind <- grepl("fuel comb(.*)coal", SCC$ei.sector, ignore.case = T);

# Get correct 'SCC' values from 'SCC' data set.
combSCC <- SCC[ind,]$scc;
# Use this values to extract information from 'NEI' data set.
combNEI <- NEI[NEI$scc %in% combSCC,];

# Melt combNEI and recast it to get total sum of coal combustion related emissions.
meltedNEI <- melt(combNEI, id = c("year"), measure.vars = c("emissions"));
castNEI <- dcast(meltedNEI, year ~ variable, sum);

# Plot using base system
png("./figures/plot4.png", bg = "transparent");
g <- ggplot(castNEI, aes(year, emissions)) + xlab("Year") + ylab("Emissions in tons") + ggtitle("Coal combustion related emissions vs years") + geom_line();
print(g);
dev.off();