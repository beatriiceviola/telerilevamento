#Second method to quantify changes in time
#The first method was based on classification

library(terra)
library(imageRy)

im.list()

#import the data
EN01<- im.import("EN_01.png")
EN13<- im.import("EN_13.png")


par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)


difEN = EN01[[1]]-EN13[[1]]
cl<- colorRampPalette(c("red", "white", "blue"))(100)
plot(difEN, col=cl)

##Ice melt in Greenland

g2000<- im.import("greenland.2015.tif")
clg<-colorRampPalette(c("black", "blue", "white", "red"))(100)
plot(g2000, col=clg)

g2005<- im.import("greenland.2005.tif")
plot(g2005, col=clg)

g2010<- im.import("greenland.2010.tif")
plot(g2010, col=clg)

g2015<- im.import("greenland.2015.tif")
plot(g2015, col=clg)


par(mfrow=c(2,2))
plot(g2000, col=clg)
plot(g2005, col=clg)
plot(g2010, col=clg)
plot(g2015, col=clg)

#stacking the data (con lo stack trasformo le immagini in bande di una stessa immagine)
greenland <-c(g2000,g2005,g2010,g2015)
plot(greenland, col=clg)

#Differenza 
#in questo modo faccio una differenza tra il 2000 (1) e il 2015(4)
difg = greenland [[1]]- greenland[[4]]
clgreen<-colorRampPalette(c("red", "white", "blue"))(100)
plot(difg, col=clgreen)

#Associo ad ogni componente dell'RGB unimmagine, ne posso usare 3 ovviamente
#2000 sulla banda del rosso, 2005 sul verde e 2015 sul blu
im.plotRGB(greenland, r=1, g=2, b=4)
#con il rosso vedo le T più alte nel 2000, con il verde quelle del 2005 e con il blu quelle del 2015



