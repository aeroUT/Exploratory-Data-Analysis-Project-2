library(plyr)
library(ggplot2)

#Creat the files needed using readRDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreNEI <- NEI[NEI$fips=="24510",]

aggTotalbaltimore <- aggregate(Emissions ~ year, baltimoreNEI, sum)

win.graph(200,200)
barplot(aggTotalbaltimore$Emissions,
        names.arg = aggTotalbaltimore$year,
        xlab="year",
        ylab = "PM2.5 Emissions (Tons)",
        main = "Total PM2.5 from all Baltimore Sources")