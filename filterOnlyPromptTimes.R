head(userGeoFile)

userGeoFile$LOG_TIME <- as.POSIXct(userGeoFile$LOG_TIME, format = "%Y-%m-%d %H:%M:%S")
userGeoFile$HEADER_TIME <- as.POSIXct(userGeoFile$HEADER_TIME, format = "%Y-%m-%d %H:%M:%S")

userGeoFile$HEADER_TIME_ONLY <- strftime(userGeoFile$HEADER_TIME, format = "%H:%M:%S")

userGeoFile$HEADER_TIME_ONLY <- as.POSIXct(userGeoFile$HEADER_TIME_ONLY, format = "%H:%M:%S")