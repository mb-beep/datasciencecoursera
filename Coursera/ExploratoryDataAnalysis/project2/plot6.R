# Script for completing project 2 of the Coursera
#  'Exploratory Data Analysis' course.
# Plots the needed 'plot6.png'

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

# Get indices of emissions from motor vehicle sources using grepl
ind <- grepl("mobile(.*)vehicles", SCC$ei.sector, ignore.case = T);

# Get correct 'SCC' values from 'SCC' data set.
vehicleSCC <- SCC[ind,]$scc;
# Use this values to extract information from 'NEI' data set and
#  extract correct fips
vehicleNEI <- NEI[NEI$scc %in% vehicleSCC,];
vehicleNEI <- subset(vehicleNEI, fips == "24510" | fips == "06037");

# Melt vehicleNEI and recast it to get total sum of motor vehicle related emissions in LA and BC.
meltedNEI <- melt(vehicleNEI, id = c("year", "fips"), measure.vars = c("emissions"));
castNEI <- dcast(meltedNEI, year + fips ~ variable, sum);

# Plot using base system
png("./figures/plot6.png", bg = "transparent");
g <- ggplot(castNEI, aes(year, emissions, color = fips)) + xlab("Year") + ylab("Emissions in tons") + ggtitle("Motor vehicle emissions vs years in BC and LA") + geom_line();
print(g);
dev.off();