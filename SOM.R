library("kohonen")
setwd("D:\\2017Qiao\\Module6\\Exe_SelfOrganizedModelling\\Day3")
remote<-read.csv("remoteness.csv", header=TRUE, sep = ";", dec= ",")
remotemat=as.matrix(remote) #convert input into matrix
remotemat.sc<-scale(remotemat) #scale all variables
# these values should range between 1 to -1. They are scaled around 0
# remotemat.sc #display input data
set.seed(7)

#  training the SOM lattice and

remotemat.som<-som(remotemat.sc, grid=somgrid(6,6,"hexagonal"),rlen=100000, keep.data=TRUE)
plot(remotemat.som)


# mapping back data
mapping <- map(remotemat.som,remotemat.sc)
plot(remotemat.som, type="mapping", pch =1, main="all")
plot (remotemat.som, type="counts", pch = 1, main="count")
plot (remotemat.som, type="dist.neighbours", pch = 1, main="distance")


remotemat.hc <- cutree(hclust(object.distances(remotemat.som,"codes")), 4)
add.cluster.boundaries(remotemat.som, remotemat.hc)

# 3. Bringing your SOM results back to a GIS
#save the mapping to a file
write.csv(mapping, file="outputfile.csv")