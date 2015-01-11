# Script for completing project 2 of the Coursera
#  'Exploratory Data Analysis' course.
# Plots the needed 'plot3.png'

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

# Melt NEI and recast it to get total sum of emissions in Baltimore City
#   per year and type
meltedNEI <- melt(NEI, id = c("year", "fips", "type"), measure.vars = c("emissions"));
castNEI <- dcast(meltedNEI, year + fips + type ~ variable, sum);
baltCity <- subset(castNEI, fips == "24510");
png("./figures/plot3.png", bg = "transparent");
g <- ggplot(baltCity, aes(year, emissions)) + geom_line(aes(color = type)) + ggtitle("Emissions in Balitmore City by type") + xlab("Year") + ylab("Emissions in tons");
print(g);
dev.off();