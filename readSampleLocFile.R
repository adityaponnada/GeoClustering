library(psych)
library(MASS)
library(dplyr)
library(revgeo)
library(ggmap)

inPath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/Location/AllUsersLocation.csv"

GeoFile <- read.csv(inPath,sep = ",", header = TRUE)

## Reverse geo code the location
##userGeoFile$PLACE <- revgeo::revgeo(userGeoFile$LONG, userGeoFile$LAT, provider = NULL, API = NULL, output = NULL, item = NULL)

user_id = "uema02@micropa_com"

userGeoFile1 <- subset(GeoFile, GeoFile$USER_ID == user_id) ### GeoFile1 contains outliers

nrow(userGeoFile1)

iqr_val <- IQR(userGeoFile1$ACC, na.rm = TRUE)
cut_off <- iqr_val*1.5

rr <- quantile(userGeoFile1$ACC, na.rm = TRUE)

rr

tippingPoint <- 19.405 + cut_off ##Insert 75th percentile here

# tippingPoint <- mean(userGeoFile1$ACC) + 3*sd(userGeoFile1$ACC)
# 
userGeoFile <- subset(userGeoFile1, userGeoFile1$ACC <= tippingPoint)

nrow(userGeoFile)

# library(plotly)
# 
# p <- plot_ly(data = userGeoFile, x = ~LAT, y = ~LONG, type = 'scatter', mode = 'markers', size = ~ACC)

## Extract unique logging times

userGeoFile <- subset(userGeoFile,!(duplicated(userGeoFile$HEADER_TIME)))


### Sort by header time stamp
userGeoFile <- userGeoFile[order(userGeoFile$HEADER_TIME),]


library(ggplot2)

#### Use user id no to denote the plots

g01 <- ggplot(data = userGeoFile, aes(x=LAT, y=LONG))+
  geom_count() +
  labs(title = user_id, subtitle = "4 week long. lat.")

gAll <- ggplot(data = GeoFile, aes(x=LAT, y=LONG))+
  geom_count() +
  labs(title = "All participantas")+
  ylim(-100, -60)

