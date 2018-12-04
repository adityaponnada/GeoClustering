library(plyr)
library(dplyr)

sortedFile <- userGeoFile

sortedFile$COUNT <- 1

weightedFile <- ddply(sortedFile,c("LAT", "LONG"),numcolwise(sum))

