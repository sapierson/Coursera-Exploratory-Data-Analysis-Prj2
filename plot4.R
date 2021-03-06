# Program Name: plot4.R
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
# 4.  Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

    source("DownloadDataFiles.R")
    
    library(ggplot2)

    # Setup working directory and data directory
    main_dir <- "C:/Users/maxim/Documents/Coursera/Exploratory Data Analysis/Assignment2/Coursera-Exploratory-Data-Analysis-Prj2"
    setwd(main_dir)
    
    # Define plot output name
    plotOutputName <- "plot4.png"
    
    # Subset coal and combustion filtered PM25 data
    combustionFiltered <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
    coalFiltered <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
    coalCombustionFiltered <- (combustionFiltered & coalFiltered)
    combustionSCC <- SCC[coalCombustionFiltered,]$SCC
    combustionPM25 <- PM25[PM25$SCC %in% combustionSCC,]
    
    # Setup plot image type
    png(plotOutputName, width = 480, height = 480, units = "px")
    
    # Generate plot

    myplot <- ggplot(combustionPM25, aes(factor(year), Emissions/10^5, fill = type)) +
        geom_bar(stat="identity", width=0.75) +
        labs(x="Year", y=expression("Total PM"[2.5]~" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]~"Coal Combustion Source Emissions Across US from 1999-2008"))
    
    print(myplot)
    
    dev.off()
    
    