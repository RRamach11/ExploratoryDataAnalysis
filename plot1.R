
## This R script checks if total emissions from PM2.5 decreased in USA
## from 1999 to 2008. Using the base plotting system, we make a plot
## showing the total PM2.5 emission from all sources for each of 
## the years 1999, 2002, 2005, and 2008.

## Here I am reading the source files. The below RDS files are already stored
## in my working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# I am using Aggregate function to Compute Summary Statistics for the above NEI data subset
Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
# I am appending a new column called 'PM' to Emissions Data subset
Emissions["PM"] <- round(Emissions[,2]/1000,2)

# I am generating emissions graph in PNG formaat, calling it 'plot1.png' 
png(filename='C:/Users/Ravi/Documents/R/Exploratory Data Analysis/plot1.png')

barplot(Emissions$PM, names.arg=Emissions$Group.1, 
        main=expression('Total Emission of PM2.5'),
        xlab='Year', ylab=expression(paste('PM2.5 in kilotons')))

dev.off()