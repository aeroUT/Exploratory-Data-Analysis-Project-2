library(plyr)
library(ggplot2)

#Creat the files needed using readRDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

aggTotal <- aggregate(Emissions ~ year, NEI, sum)

win.graph(200,200)
barplot((aggTotal$Emissions)/10^6,
        names.arg = aggTotal$year,
        xlab="year",
        ylab = "PM2.5 Emissions (10^6 Tons)",
        main = "Total PM2.5 from all US Sources")