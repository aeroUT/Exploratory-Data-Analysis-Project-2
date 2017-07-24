library(plyr)
library(ggplot2)

#Creat the files needed using readRDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("[Hh]ighway [Vv]ehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
baltimoreVehiclesNEI$city <- "Baltimore City"
LAVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
LAVehiclesNEI$city <- "Los Angles County"

cityNEI <- rbind(baltimoreVehiclesNEI, LAVehiclesNEI)

ggp <- ggplot(cityNEI,aes(factor(year),Emissions,fill=year)) +
      geom_bar(stat="identity") +
      theme_bw() + guides(fill=FALSE)+
      facet_grid(.~city,scales = "free",space="free") + 
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
      labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

win.graph(200,200)
print(ggp)