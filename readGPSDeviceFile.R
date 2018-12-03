GPS_device <- read.csv("C:/Users/Dharam/Downloads/GPS_Device_Data/Trip data.csv", sep = ",", header = TRUE)


#GPS_device <- subset(GPS_device, !GPS_device$ï..INDEX = "INDEX")

GPS_device <- subset(GPS_device, GPS_device$LONGITUDE != 0.00)

library(ggmap)
library(tidyverse)


# map.boston <- ggmap::get_map("Tokyo")
# 
# ggmap(map.boston)

# 
# library(plotly)
# 
# pMap <- plot_geo(userGeoFile, lat = ~LAT, lon = ~LONG) %>%
#   add_markers(
#     text = ~paste(LAT, LONG, ACC, sep = "<br />"),hoverinfo = "text")
# 
# 
# 
# get_map("Japan", zoom = 5) %>% ggmap()


qmplot(LONGITUDE, LATITUDE, data = GPS_device, color = I('red'), size = I(3), darken = 0.3)


gPlot_device <- ggplot(data = GPS_device, aes(x=LATITUDE, y=LONGITUDE))+
  geom_count() +
  labs(title = "Two day data", subtitle = "Using Quartz GPS")


### Get location:
