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
