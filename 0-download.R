# Save actual working directory
rootDirectory <- getwd()

# Define data set directory
dataDirectory <- paste(rootDirectory, "/UCI HAR Dataset", sep="")

# Define data file url
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Define destination file
fileDestinationName <- "data.zip"


if (!file.exists(dataDirectory)) {
    # Download data file
    download.file(fileUrl, fileDestinationName, method = "curl")
    
    # Extract data file
    unzip(fileDestinationName)
    
    # Remove data file
    file.remove(fileDestinationName)
}

# Set data directory
setwd(dataDirectory)
