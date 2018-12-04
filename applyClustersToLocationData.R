head(clusteredPoints)

head(userGeoFile)

userGeoFile$CLUSTER <- NA

for (i in 1:nrow(userGeoFile)){
  
  print(paste0("at i ", i))
  
  pickedRow <- userGeoFile[i,]
  
  for (j in 1:nrow(clusteredPoints)){
    
    pickedCluster <- clusteredPoints[j,]
    
    if ((pickedRow$LAT == pickedCluster$LAT) & (pickedRow$LONG == pickedCluster$LONG)){
      
      userGeoFile$CLUSTER[i] <- pickedCluster$CLUSTER
      
      break
      
    }
    
  }
  
}


userGeoFile$CLUSTER_ID <- as.factor(userGeoFile$CLUSTER)


### Plot the clustered distribution
qmplot(LONG, LAT, data = userGeoFile, color = I("green"), size = I(3), darken = 0.3)
g01Clustered <- ggplot(data = userGeoFile, aes(x=LAT, y=LONG, color = CLUSTER_ID))+
  geom_count() +
  labs(title = user_id, subtitle = "4 week long. lat.")


