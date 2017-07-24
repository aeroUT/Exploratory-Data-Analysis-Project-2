library(plyr)
library(ggplot2)

#Creat the files needed using readRDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset coal combustion related NEI data
comb.Related <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal.Related <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal.Comb <- (comb.Related & coal.Related)
comb.SCC <- SCC[coal.Comb,]$SCC
comb.NEI <- NEI[NEI$SCC %in% comb.SCC,]

ggp <- ggplot(comb.NEI,aes(factor(year),Emissions/10^5)) +
      geom_bar(stat="identity",fill="grey",width=0.75) +
      theme_bw() +  guides(fill=FALSE) +
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
      labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

win.graph(200,200)
print(ggp)