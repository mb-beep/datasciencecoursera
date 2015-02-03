# This script will download (if not done already) and
#  unzip the necessary files for the week 4 video.
# In a second step, it will read in the data.

url2012 = "http://www.epa.gov/ttn/airs/airsaqs/detaildata/501files/RD_501_88101_2012.zip";
url1999 = "http://www.epa.gov/ttn/airs/airsaqs/detaildata/501files/Rd_501_88101_1999.Zip";

if(!file.exists("./data/RD_501_88101_2012-0.txt")) {
    download.file(url2012, destfile = "./data/RD_501_88101_2012.zip", mode = "wb");
    unzip("./data/RD_501_88101_2012.zip", exdir = "./data");
    file.remove("./data/RD_501_88101_2012.zip");
}

if(!file.exists("./data/Rd_501_88101_1999-0.txt")) {
    download.file(url1999, destfile = "./data/RD_501_88101_1999.zip", mode = "wb");
    unzip("./data/RD_501_88101_1999.zip", exdir = "./data");
    file.remove("./data/RD_501_88101_1999.zip");
}

data12 = read.table("./data/RD_501_88101_2012-0.txt")

data99