library(sp)
library(geosphere)



distanceData <- data.frame(START_TIME = NA, STOP_TIME = NA, DIST = NA, LAT1 = NA, LONG1 = NA, LAT2 = NA, LONG2 = NA)

#userGeoFile$LOG_TIME <- as.POSIXct(userGeoFile$LOG_TIME, format = "%Y-%m-%d %H:%M:%OS")


#userGeoFile$LOG_TIME <- as.POSIXct(userGeoFile$LOG_TIME, format = "%Y-%m-%d %H:%M:%OS")
start_time = as.POSIXct(start_time)
stop_time = as.POSIXct(stop_time)

test <- userGeoFile

test$HEADER_TIME <- as.character(test$HEADER_TIME)

for (i in 1:nrow(test)){
  
  print(paste0("i is ", i))
  
  start_time <- test$HEADER_TIME[i]
  stop_time <- test$HEADER_TIME[i+1]
  dist_diff <- distHaversine(c(test$LONG[i], test$LAT[i]), c(test$LONG[i+1], test$LAT[i+1]))
  lat1 <- test$LAT[i]
  long1 <- test$LONG[i]
  lat2 <- test$LAT[i+1]
  long2 <- test$LONG[i+1]
  
  tempVector <- c(START_TIME = start_time, STOP_TIME = stop_time, DIST = dist_diff, LAT1 = lat1, LONG1 = long1, LAT2 = lat2, LONG2 = long2)
  
  distanceData <- rbind(distanceData, tempVector)
  
}



distanceData <- distanceData[-1,]
distanceData <- distanceData[-nrow(distanceData),]

distanceData$START_TIME <- as.POSIXct(distanceData$START_TIME, format = "%Y-%m-%d %H:%M:%OS")

distanceData$STOP_TIME <- as.POSIXct(distanceData$STOP_TIME, format = "%Y-%m-%d %H:%M:%OS")
distanceData$DIST <- as.numeric(distanceData$DIST)

distanceData$TIME_DIFF <- difftime(distanceData$STOP_TIME, distanceData$START_TIME, units = "mins")
distanceData$TIME_DIFF <- as.numeric(distanceData$TIME_DIFF)
distanceData$DIST_MIN <- distanceData$DIST/distanceData$TIME_DIFF


library(plotly)

distPlot <- plot_ly(data = distanceData, x = ~STOP_TIME, y = ~DIST_MIN, type = 'scatter', mode = 'markers', color = 'rgba(255, 182, 193, .9)')

library(ggplot2)

#p <-ggplot(data=distanceData, aes(x=STOP_TIME, y=DIST)) +
  #geom_bar()

savePath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/Location/uema01_loc/distanceData_UniqueTimes.csv"

write.csv(distanceData, file = savePath, row.names = FALSE, sep = ",")
