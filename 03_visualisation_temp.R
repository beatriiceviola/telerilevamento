#Satellite data visualisation in R by imageRy

library(terra)
library(imageRy)

#List of data avialable in imageRy
im.list()

#Importing data
mato <- im.import("matogrosso_ast_2006209_lrg.jpg")
b2<- im.import("sentinel.dolomites.b2.tif" )

#Plotting the data
plot(mato)

#Cambiamo la scala di colori
clg<-colorRampPalette(c("black", "grey", "light grey"))(3)

#Plotting the data
plot(b2, col=clg)

#Cambiamo scala di colori di nuovo
clch<-colorRampPalette(c("cyan4","magenta","cyan", "chartreuse"))(100)

#Plotting the data
plot(b2, col= clch)

#Importing the additional bands
b3 <- im.import("sentinel.dolomites.b3.tif")  
plot(b3, col=clch)
b4<-im.import("sentinel.dolomites.b4.tif")
plot(b4, col=clch)
b8 <- im.import("sentinel.dolomites.b8.tif")  
plot(b8, col=clch)
                         
