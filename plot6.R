# Program Name: plot6.R
# Author: Shawne A. Pierson
# Date: February 19, 2017
#
# 
# Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that
# it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked
# with setting national ambient air quality standards for fine PM and for tracking the emissions of this
# pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions
# of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information
# about the NEI at the EPA National Emissions Inventory web site "http://www.epa.gov/ttn/chief/eiinformation.html".
#
# For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that
# source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.
#
# You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to
# make a single plot. Unless specified, you can use any plotting system in R to make your plot.
#
# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources
#    in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

    source("DownloadDataFiles.R")
    
    library(ggplot2)
    library(plyr)

    # Setup working directory and data directory
    main_dir <- "C:/Users/maxim/Documents/Coursera/Exploratory Data Analysis/Assignment2/Coursera-Exploratory-Data-Analysis-Prj2"
    setwd(main_dir)
    
    # Define plot output name
    plotOutputName <- "plot6.png"
    
    # Obtain vehicles from SCC data
    vehicles <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
    vehiclesFiltered <- SCC[SCC$EI.Sector %in% vehicles, ]["SCC"]
    
    # Subset vehicle filtered PM25 data
    filteredPM25 <- PM25[PM25$SCC %in% vehiclesFiltered$SCC & (PM25$fips == "24510" | PM25$fips == "06037"),]

    # Execute tapply to summarize the PM25 emissions by year
    totalPM25yr <- ddply(filteredPM25, .(year, fips), function(x) sum(x$Emissions))
    
    ## Rename the col: Emissions
    colnames(totalPM25yr)[3] <- "Emissions"
    
    ## Add the col: City
    totalPM25yr$City <- ifelse(totalPM25yr$fips == "06037", "Los Angeles", "Baltimore")
    
    # Setup plot image type
    png(plotOutputName, width = 800, height = 800, units = "px")
    
    # Generate plot
    ggp <- qplot(year, Emissions, data=totalPM25yr, color=City, geom ="line") +
        ggtitle("Baltimore City & Los Angeles County" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year") +
        theme(plot.title = element_text(hjust = 0.5)) +
        xlab("Year") + ylab("Total" ~ PM[2.5] ~ "Emissions (tons)")
    
    print(ggp)
    
    dev.off()
    
    