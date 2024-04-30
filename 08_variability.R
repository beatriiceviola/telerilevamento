#Measuring spatial variability 

library(imageRy)
library(terra)

im.list()
sent <- im.import("sentinel.png")

im.plotRGB (sent, r=1, g=2, b=3)

#nir = band 1
#red = band 2
#green = band 3

#nir on green
im.plotRGB (sent, r=2, g=1, b=3)

#variability 
nir <- sent[[1]] 
plot(nir)

cl <- colorRampPalette(c("red","orange","yellow"))(100)
plot(nir, col=cl)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

#installing packages
install.packages("viridis")
library(viridis)

viridisc <- colorRampPalette(viridis(7))(256)
plot(sd3, col= viridisc)

#calculate the sd of a moving window of 7 pixels

sd7 <- focal (nir, matrix(1/49,7,7), fun=sd)
plot(sd7)
plot(sd7, col=viridisc)

sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)
plot(sd13, col= viridisc)

sdstack <- c(sd3, sd7, sd13)
plot(sdstack, col=viridisc)



