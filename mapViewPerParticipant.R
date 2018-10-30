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


qmplot(LONG, LAT, data = userGeoFile, color = I('red'), size = I(3), darken = 0.3)
                                                                