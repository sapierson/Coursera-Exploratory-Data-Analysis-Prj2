# Program Name: DownloadDataFiles.R
# Author: Shawne A. Pierson
# Date: February 18, 2017
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
# The purpose of this program is to download and unzip the Data for Peer Assessment
#  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" for use with all plot[1-6].R programs.
#
#

    # Clean up workspace
    rm(list=ls())
    
    library(RCurl)
    
    # Setup working directory and data directory
    main_dir <- "C:/Users/maxim/Documents/Coursera/Exploratory Data Analysis/Assignment2/Coursera-Exploratory-Data-Analysis-Prj2"
    sub_dir <- "data"
    source_file1 <- "Source_Classification_Code.rds"
    source_file2 <- "summarySCC_PM25.rds"
    
    targetFileName <- c("./NEI_metrics_dataset.zip")                            # Download file name
    
    # Check for the existance of the data directory.  If the directory does not exist, then create it!
    if (file.exists(sub_dir)){
        setwd(file.path(main_dir, sub_dir))
    } else {
        dir.create(file.path(main_dir, sub_dir))
        setwd(file.path(main_dir, sub_dir))
        
    }
    
    # Check for the existance of our targetFilename
    if (!file.exists(targetFileName)) {
        
        # Setup download variables
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileurl, destfile <- targetFileName)
        
        ddfile <- c("NEI_metrics_dataset_dd.txt")                              # Download date file
        
        # write download date file for tracking purposes
        fileConn <- file(ddfile)
        writeLines(date(), fileConn)
        close(fileConn)
    }
    
    # If our source_file1 and source_file2 files do not exist, then unzip the targetFileName
    if (!(file.exists(source_file1) && file.exists(source_file2))) {
        unzip(targetFileName)
    }
    
    # Load RDS files into memory for use with plot[1-6].R
    SCC <- readRDS(source_file1)
    PM25 <- readRDS(source_file2)
    
    setwd(main_dir)
