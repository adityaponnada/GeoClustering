library(factoextra)
library(fpc)
library(fossil)
library(revgeo)

library(dbscan)

keep <- c("LAT", "LONG")

userCoordFile <- userGeoFile[, keep]

collapsedFile <- userCoordFile

#userCoordFile <- head(userCoordFile, 1440)

# km.res <- kmeans(userCoordFile, 7, nstart = 25)
# fviz_cluster(km.res, userCoordFile, frame = FALSE, geom = "point")
# 
# dist <- earth.dist(userCoordFile, dist = T)
# 
# db_object <- fpc::dbscan(dist, 0.5, MinPts = 25, method = "dist")
# plot(db_object, userCoordFile, main = "DBSCAN", frame = FALSE)

collapsedFile <- subset(userCoordFile,!(duplicated(userCoordFile$LAT) & duplicated(userCoordFile$LONG)))

# km.res <- kmeans(collapsedFile, 5, nstart = 25)
# fviz_cluster(km.res, collapsedFile, frame = FALSE, geom = "point")

dist <- earth.dist(collapsedFile, dist = T)

db_object <- fpc::dbscan(dist, 1.5, MinPts = 20, method = "dist")
plot(db_object, collapsedFile, main = "DBSCAN", frame = FALSE)

hdb_object <- hdbscan(collapsedFile, 10, xdist = dist, gen_hdbscan_tree = FALSE,
                      gen_simplified_tree = FALSE)

db_object2 <- dbscan(dist, 5.0, minPts = 10.0, weights = NULL, collapsedFile)

clusteredPoints <- collapsedFile

clusteredPoints$CLUSTER <- db_object$cluster
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


