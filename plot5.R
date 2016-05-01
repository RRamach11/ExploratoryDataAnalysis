
## This R script checks if emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
## I show the result by producing a plot using barplot

## Here I am reading the source files. The below RDS files are already stored
## in my working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Here I am creating a subset containing only Baltimore data of type 'On Road'
BaltimoreTypeOnroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Here I am aggregating emission values by the year
Emissions <- aggregate(BaltimoreTypeOnroad[, 'Emissions'], by=list(BaltimoreTypeOnroad$year), sum)
Emissions["PM"] <- round(Emissions[,2]/1000,2)

# I am generating emissions graph in PNG formaat, calling it 'plot1.png' 
png(filename='C:/Users/Ravi/Documents/R/Exploratory Data Analysis/plot05.png')

barplot(Emissions$PM, names.arg=Emissions$Group.1, 
        main=expression('Total Baltimore City On Road Emissions of PM2.5'),
        xlab='Year', ylab=expression(paste('PM2.5 in kilotons')))

dev.off()















