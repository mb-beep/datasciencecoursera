# Script for completing project 2 of the Coursera
#  'Exploratory Data Analysis' course.
# Plots the needed 'plot1.png'

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

# Melt NEI and recast it to get total sum of emissions per year.
# Set 'measure.vars' to 'emissions' to cast sum on it and save plot
#  as a png-file with transparent background.
meltedNEI <- melt(NEI, id = c("year"), measure.vars = c("emissions"));
castNEI <- dcast(meltedNEI, year ~ variable, sum);
png("./figures/plot1.png", bg = "transparent");
with(castNEI, plot(year, emissions, type = "b", lty = 2, lwd = 2, pch = 19, main = "Total emissions vs. years", xlab = "Year", ylab = "Total emisions in tons"));
dev.off();