
## This R script checks if total emissions from PM2.5 decreased in the
## Baltimore City, Maryland (fips == "24510") from 1999 to 2008? I Use the 
## base plotting system to make a plot to find the answer

## Here I am reading the source files. The below RDS files are already stored
## in my working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Here I am subsetting data related to Baltimore City
BaltimoreCity <- subset(NEI, fips=='24510')

# I am using Aggregate function to Compute Summary Statistics for the above NEI data subset
Emissions <- aggregate(BaltimoreCity[, 'Emissions'], by=list(BaltimoreCity$year), FUN=sum)
# I am appending a new column called 'PM' to Emissions Data subset
Emissions["PM"] <- round(Emissions[,2]/1000,2)

# I am generating emissions graph forBaltimore City in PNG format, calling it 'plot2.png' 
png(filename='C:/Users/Ravi/Documents/R/Exploratory Data Analysis/plot2.png')

barplot(Emissions$PM, names.arg=Emissions$Group.1, 
        main=expression('Total Emission of PM2.5 in Baltimore CIty'),
        xlab='Year', ylab=expression(paste('PM2.5 in kilotons')))

dev.off()