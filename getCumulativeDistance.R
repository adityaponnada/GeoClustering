cumulativeDist <- distanceData

# cumulativeDist <- subset(cumulativeDist, !is.nan(cumulativeDist$DIST_MIN))
# cumulativeDist <- subset(cumulativeDist, cumulativeDist$DIST_MIN != Inf)

cumulativeDist$CUM_DIST <- NA

cumulativeDist$CUM_DIST[1] <- cumulativeDist$DIST[1]

for (i in 2:nrow(cumulativeDist)){
  
  
  print(paste0("i is ", i))
  
  cumulativeDist$CUM_DIST[i] <- cumulativeDist$CUM_DIST[i-1] + cumulativeDist$DIST[i]
}


library(plotly)


## 4 weeks cumulative distance

cumPlot4Weeks <- plot_ly(data = cumulativeDist, x = ~STOP_TIME, y = ~CUM_DIST, type = 'scatter', mode = "markers") 

## for the 4 weeks

# cumPlotWeek1 <- plot_ly(data = cumulativeDist, x = ~STOP_TIME, y = ~CUM_DIST, type = 'scatter', 
#                         mode = 'markers') %>% layout(xaxis = list(range = as.POSIXct(c('2018-02-02 00:00:00', '2018-02-09 23:00:00'))))
# 
# cumPlotWeek2 <- plot_ly(data = cumulativeDist, x = ~STOP_TIME, y = ~CUM_DIST, type = 'scatter', 
#                         mode = 'markers') %>% layout(xaxis = list(range = as.POSIXct(c('2018-02-10 00:00:00', '2018-02-16 23:00:00'))))
# 
# cumPlotWeek3 <- plot_ly(data = cumulativeDist, x = ~STOP_TIME, y = ~CUM_DIST, type = 'scatter', 
#                         mode = 'markers') %>% layout(xaxis = list(range = as.POSIXct(c('2018-02-17 00:00:00', '2018-02-23 23:00:00'))))
# 
# cumPlotWeek4 <- plot_ly(data = cumulativeDist, x = ~STOP_TIME, y = ~CUM_DIST, type = 'scatter', 
#                         mode = 'markers') %>% layout(xaxis = list(range = as.POSIXct(c('2018-02-24 00:00:00', '2018-03-02 23:00:00'))))


subplot(cumPlotWeek1, cumPlotWeek2, cumPlotWeek3, cumPlotWeek4, nrows = 4)




#### Apply median filtering to distance

cumulativeDist$MED_FILTERED <- runmed(cumulativeDist$DIST, 3)


