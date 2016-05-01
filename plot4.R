
## This R script how have emissions from coal combustion-related sources changed from 1999-2008

## Here I am reading the source files. The below RDS files are already stored
## in my working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# I am filtering and storing Coal combustion related sources in dataset SCC.coal
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge NEI and SCC.coal datasets.After merge I am aggregating and finding sums by the year 
datasetMerge <- merge(x=NEI, y=SCC.coal, by='SCC')
aggregateAfterMerge <- aggregate(datasetMerge[, 'Emissions'], by=list(datasetMerge$year), sum)
colnames(aggregateAfterMerge) <- c('Year', 'Emissions')

# I am generating a line graph using ggplot and storing in PNG format, calling it 'plot4.png' 
png(filename='C:/Users/Ravi/Documents/R/Exploratory Data Analysis/plot4.png')

ggplot(data=aggregateAfterMerge, aes(x=Year, y=Emissions/1000)) + 
  geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
  ggtitle(expression('Total Emissions of PM2.5')) + 
  ylab(expression(paste('PM2.5 in kilotons'))) + 
  geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
  theme(legend.position='none') + scale_colour_gradient(low='black', high='red')

dev.off()


