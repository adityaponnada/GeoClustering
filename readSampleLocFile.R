library(psych)
library(MASS)
library(dplyr)
library(revgeo)
library(ggmap)

inPath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/Location/AllUsersLocation.csv"

GeoFile <- read.csv(inPath,sep = ",", header = TRUE)

## Reverse geo code the location
##userGeoFile$PLACE <- revgeo::revgeo(userGeoFile$LONG, userGeoFile$LAT, provider = NULL, API = NULL, output = NULL, item = NULL)

user_id = "uema30@micropa_com"

userGeoFile <- subset(GeoFile, GeoFile$USER_ID == user_id)

# library(plotly)
# 
# p <- plot_ly(data = userGeoFile, x = ~LAT, y = ~LONG, type = 'scatter', mode = 'markers', size = ~ACC)


library(ggplot2)

#### Use user id no to denote the plots

g30 <- ggplot(data = userGeoFile, aes(x=LAT, y=LONG))+
  geom_count() +
  labs(title = user_id, subtitle = "1 week long. lat.")

gAll <- ggplot(data = GeoFile, aes(x=LAT, y=LONG))+
  geom_count() +
  labs(title = "All participantas")+
  ylim(-100, -60)



AllGeoPath = ""

write.csv(GeoFile, file = "MyData.csv")