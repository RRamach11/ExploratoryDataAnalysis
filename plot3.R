
## This R script checks the four types of sources indicated by the 
## type (point, nonpoint, onroad, nonroad) variable, and which of these four 
## sources have seen decreases in emissions from 1999-2008 for Baltimore City,
## and Which have seen increases in emissions from 1999-2008? 
## Using the ggplot2 plotting system we make a plot to answer this question.

## Here I am reading the source files. The below RDS files are already stored
## in my working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Here I am subsetting data related to Baltimore City and 
# ignoring data that falls outside of years 1999,2002,205, and 2008
BaltimoreCity <- subset(NEI, fips=='24510')
BaltimoreCity$year <- factor(BaltimoreCity$year, levels=c('1999', '2002', '2005', '2008'))

# I am generating graph using ggplot and storing in PNG format, calling it 'plot3.png' 

png(filename='C:/Users/Ravi/Documents/R/Exploratory Data Analysis/plot3.png', width=800, height=500, units='px')

ggplot(data=BaltimoreCity, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
  geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
  ylab(expression(paste('Log of PM 2.5 Emissions'))) + xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore City')  +
  geom_jitter(alpha=0.15)

dev.off()


