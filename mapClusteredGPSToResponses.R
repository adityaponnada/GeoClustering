head(clusteredPoints)
head(uEMAUser)

uEMAUser$LOC_CLUSTER <- NA
mappedGPSuEMA <- uEMAUser

clusteredPoints$HEADER_TIME <- as.POSIXct(clusteredPoints$HEADER_TIME, format = "%Y-%m-%d %H:%M:%S")

timeBefore = 600

k = 0




for (i in 1:nrow(uEMAUser)){
  
  print(paste0("At i: ", i))
  
  uEMAPickedRow <- uEMAUser[i,]
  
  k = k + 1
  
  if (k > nrow(clusteredPoints)){
    print("Maxed out in the second file ... exiting")
    
    break
  }
  
  tempDataFrame <- data.frame()
  
  for (j in k:nrow(clusteredPoints)){
    print(paste0("At j ", j, " and k at ", k))
    
    clusterPickedRow <- clusteredPoints[j, ]
    
    timeDifference = difftime(uEMAPickedRow$PROMPT_TIME, clusterPickedRow$HEADER_TIME, units = "secs")
    print(paste0("Time diff is ", timeDifference))
    
    
    if (timeDifference <= timeBefore & timeDifference >=0){
      print(paste0("Time diff is within range ", timeDifference))
      tempDataFrame <- rbind(tempDataFrame, clusterPickedRow)
      
      ### Get mode of the cluster ID
      
      clusterMode <- names(table(clusterPickedRow$CLUSTER))[table(clusterPickedRow$CLUSTER) == max(table(clusterPickedRow$CLUSTER))]
      
      ## Assign to a new column
      mappedGPSuEMA$LOC_CLUSTER[i] <- clusterMode
      
      k = j
    } else if (timeDifference < 0){
      
      print("Time diff -ve ... exiting")
      break
    }
  }
}

## Convert cluster to factor
mappedGPSuEMA$LOC_CLUSTER <- as.factor(mappedGPSuEMA$LOC_CLUSTER)
mappedGPSuEMA$LOC_CLUSTER[is.na(mappedGPSuEMA$LOC_CLUSTER)] <- "0"

# mappedGPSuEMA$LOCATION <- mappedGPSuEMA$LOC_CLUSTER
# 
# mappedGPSuEMA$LOCATION[is.na(mappedGPSuEMA$LOC_CLUSTER)] <- "Unknown"
# mappedGPSuEMA$LOCATION[mappedGPSuEMA$LOC_CLUSTER == "0"] <- "Border"

clusters <- as.factor(levels(mappedGPSuEMA$LOC_CLUSTER))

responseLoc <- data.frame(USER_ID = user_id, CLUSTER = NA, RESP_RATE = NA)


for (l in 1:length(clusters)){
  
  print(paste0("Finished with the cluster ID ", clusters[l]))
  
  subsetCluster <- subset(mappedGPSuEMA, mappedGPSuEMA$LOC_CLUSTER == clusters[l])
  clustTable <- table(subsetCluster$RESPONDED)
  
  
  for (c in 1:length(clustTable)){
    if (length(clustTable) == 1){
      RR <- 1.0
    } else {
      RR <- clustTable[2]/(clustTable[1] + clustTable[2])
      
    }
  }
  
  clustRow <- data.frame(USER_ID = user_id, CLUSTER = clusters[l], RESP_RATE = RR)
  responseLoc <- rbind(responseLoc, clustRow)
  
}

responseLoc <- responseLoc[-1,]

library(ggplot2)


plotClust <-ggplot(data=responseLoc, aes(x=CLUSTER, y=RESP_RATE)) +
  geom_bar(stat="identity")

plotClust

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


multiplot(plotClust, g01Clustered, g01, cols = 3)
