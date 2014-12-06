download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "./week4/q1.csv");
df1 <- read.csv("./week4/q1.csv", header = T);
names(df1) <- tolower(names(df1));
splitNames <- strsplit(names(df1), "wgtp");
splitNames[[123]];

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "./week4/q2.csv");
df2 <- read.csv("./week4/q2.csv", header = F, skip = 5, stringsAsFactors = F);
df2 <- select(df2, V1, V2, V4, V5);
names(df2) <- c("CountryCode", "Ranking","Long.Name", "GDP");
df2$GDP <- as.numeric(gsub(",", "", df2$GDP));
df2$Ranking <- as.numeric(gsub(",", "", df2$Ranking));
df2 <- df2[1:190,];
mean(df2$GDP);

grep("^United",df2$Long.Name)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "./week4/q4.csv");
df3 <- read.csv("./week4/q4.csv", header = T, stringsAsFactors = F);
names(df3) <- gsub("\\.", "", names(df3));
names(df3) <- tolower(names(df3));
names(df2) <- sub("\\.", "", names(df2));
names(df2) <- tolower(names(df2));
m <- merge(df2, df3, by.x = "countrycode", by.y = "countrycode");
length(grep("Fiscal year end: June", m$specialnotes));

amzn = getSymbols("AMZN", auto.assign = FALSE);
sampleTimes = index(amzn);
df4 <- as.data.frame(amzn);
dim(amzn["2012"])[1];
df4 <- amzn["2012"];
sum(wday(df4[,1],label=T) == "Mon");