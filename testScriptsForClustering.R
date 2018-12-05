library(factoextra)
library(fpc)
library(fossil)
library(revgeo)

library(dbscan)

keep <- c("LAT", "LONG")

userCoordFile <- userGeoFile[, keep]

collapsedFile <- userCoordFile

#headuserGeo <- head(userCoordFile, 10)

#headCollapsed <- subset(headuserGeo,!(duplicated(headuserGeo$LAT) & duplicated(headuserGeo$LONG)))

# dist1 <- earth.dist(headuserGeo, dist = T)
# dist2 <- earth.dist(headCollapsed, dist = T)

dataMat <- data.matrix(userCoordFile, rownames.force = NA)

# db_objectSmall <- fpc::dbscan(dist1, 1.0, MinPts = 10, method = "dist")
# plot(db_objectSmall, headuserGeo, main = "DBSCAN", frame = FALSE)
# 
#db_object_dbscan <- dbscan::dbscan(dataMat,eps = 0.1, minPts = 5, weights = NULL, borderPoints = TRUE)
#db_object_2 <- dbscan::dbscan(select(userCoordFile, LAT, LONG),eps = 0.15)

#userCoordFile <- head(userCoordFile, 1440)

# km.res <- kmeans(userCoordFile, 7, nstart = 25)
# fviz_cluster(km.res, userCoordFile, frame = FALSE, geom = "point")
# 
# dist <- earth.dist(userCoordFile, dist = T)
# 
# db_object <- fpc::dbscan(dist, 0.5, MinPts = 25, method = "dist")
# plot(db_object, userCoordFile, main = "DBSCAN", frame = FALSE)

#collapsedFile <- subset(userCoordFile,!(duplicated(userCoordFile$LAT) & duplicated(userCoordFile$LONG)))

# km.res <- kmeans(collapsedFile, 5, nstart = 25)
# fviz_cluster(km.res, collapsedFile, frame = FALSE, geom = "point")

#dist <- earth.dist(collapsedFile, dist = T)

##Default 0.05, set to 0.00010 to test

db_object <- fpc::dbscan(dataMat, 0.00010, MinPts = 180, method = "raw", scale = FALSE)
plot(db_object, userCoordFile, main = "DBSCAN", frame = FALSE)

# hdb_object <- hdbscan(collapsedFile, 10, xdist = dist, gen_hdbscan_tree = FALSE,
#                       gen_simplified_tree = FALSE)
# 
# db_object2 <- dbscan(dist, 5.0, minPts = 10.0, weights = NULL, collapsedFile)

clusteredPoints <- userGeoFile

clusteredPoints$CLUSTER <- db_object$cluster

table(clusteredPoints$CLUSTER)

clusteredPoints$CLUSTER_ID <- as.factor(clusteredPoints$CLUSTER)

g01Clustered <- ggplot(data = clusteredPoints, aes(x=LAT, y=LONG, color = CLUSTER_ID))+
  geom_count() +
  labs(title = user_id, subtitle = "4 week long. lat.")
# collapsedFile$PLACE <- revgeo(collapsedFile$LONG, collapsedFile$LAT)
# 
# x <- paste0(collapsedFile$LONG, "/", collapsedFile$LAT)
# library(ggmap)
# y <- ggmap::revgeocode(c(collapsedFile$LONG, collapsedFile$LAT), output = c("address"))
# 
# 
# keep2 <- c("LONG", "LAT")
# 
# collapsedFile <- collapsedFile[, keep2]
# 
# collapsedFile <- head(collapsedFile, 50)


