library(sf)
library(raster)
library(spData)
# library(spDataLarge)

names(world)
head(world)
world$geom[1]


world_asia = world[world$continent == "Asia", ]
asia = st_union(world_asia)

plot(world["pop"], reset = FALSE)
plot(asia, add = TRUE, col = "red")
