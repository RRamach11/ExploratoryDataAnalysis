
## This R script Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles 
## County, California (fips == "06037"). We will find which city has seen greater changes over time 
## in motor vehicle emissions

## Here I am reading the source files. The below RDS files are already stored
## in my working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore City data
# Subset Los Angeles County data
Baltimore <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
LosAngeles <- subset(NEI, fips == '06037' & type == 'ON-ROAD')


# Here I am aggregating emission values by the year
BAEmissions <- aggregate(Baltimore[, 'Emissions'], by=list(Baltimore$year), sum)
BAEmissions["PM"] <- round(BAEmissions[,2]/1000,2)
LAEmissions <- aggregate(LosAngeles[, 'Emissions'], by=list(LosAngeles$year), sum)
LAEmissions["PM"] <- round(LAEmissions[,2]/1000,2)

# I am generating emissions graph in PNG format, calling it 'plot6.png' 
png(filename='C:/Users/Ravi/Documents/R/Exploratory Data Analysis/plot6.png')

par(mfrow = c(1,2), mar= c(5,4,1,1))

barplot(BAEmissions$PM, names.arg=BAEmissions$Group.1, 
        main=expression('Baltimore On Road Emissions'),ylim = c(0, 6),
        xlab='Year', ylab=expression(paste('PM2.5 in kilotons')))

barplot(LAEmissions$PM, names.arg=LAEmissions$Group.1, 
        main=expression('LA On Road Emissions'), ylim = c(0, 6),
        xlab='Year', ylab=expression(paste('PM2.5 in kilotons')))


dev.off()


