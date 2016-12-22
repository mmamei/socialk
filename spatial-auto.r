library(spdep)
library(maptools)
library(leaflet)
require(RColorBrewer)

synch.data = read.csv("features-data.csv", header = TRUE, sep = ",",stringsAsFactors=FALSE)
names(synch.data)[1] = "NAME_2"
synch.data$avg_within <- scale(synch.data$avg_within)
synch.data$avg_between <- scale(synch.data$avg_between)
synch.data$rpc <- scale(synch.data$rpc)

ita.poly = readShapePoly("italy-shp/ITA_adm2.shp");
ita.poly@data$NAME_2 = tolower(ita.poly@data$NAME_2)


ita.poly = ita.poly[ita.poly@data$NAME_2 %in% synch.data$NAME_2,]
data = merge(ita.poly,synch.data,by = "NAME_2")


#plot(data)


#qpal = colorQuantile("OrRd",data$avg_intra,n=9)
#leaflet(data) %>%
#  addPolygons(stroke = FALSE, fillOpacity = 0.8, smoothFactor = 0.5, color = ~qpal(avg_intra)) %>%
#  addTiles()


blood.ols = lm(blood~avg_within+avg_between+rpc, data=data@data)
summary(blood.ols)

referendum.ols = lm(referendum~avg_within+avg_between+rpc, data=data@data)
summary(referendum.ols)

assoc.ols = lm(assoc~avg_within+avg_between+rpc, data=data@data)
summary(assoc.ols)



coords = coordinates(data)
W = nb2listw(dnearneigh(coords,0,200,longlat = TRUE))
#plot(W,coords);



qpal = colorQuantile("OrRd",data$blood,n=5)
map = leaflet(data) %>% addTiles() %>% 
addPolygons(stroke = TRUE, fillOpacity = 0.8, smoothFactor = 0.5, color ="red")
for(i in 1:length(W$neighbours)){
  v1 = coords[i,]
  #str(coords[i,])
  #str(W$neighbours[[i]])
  for(j in 1:length(W$neighbours[[i]])) {
    #str(coords[W$neighbours[[i]][j],])
    v2 = coords[W$neighbours[[i]][j],]
    map <- addPolylines(map,lng=c(v1[1],v2[1]),lat=c(v1[2],v2[2]), color="BLACK")
  }
}
map


moran.blood.lm = lm.morantest(blood.ols,W,alternative="two.sided")
print(moran.blood.lm)

moran.referendum.lm = lm.morantest(referendum.ols,W,alternative="two.sided")
print(moran.referendum.lm)

moran.assoc.lm = lm.morantest(assoc.ols,W,alternative="two.sided")
print(moran.assoc.lm)





