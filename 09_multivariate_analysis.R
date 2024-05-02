#Multivariate analysis

library(terra)
library(imageRy)
library(viridis)

#listiamo
im.list()

#importiamo le singole bande
b2 <- im.import("sentinel.dolomites.b2.tif") #blue       
b3 <- im.import("sentinel.dolomites.b3.tif") #green                    
b4 <- im.import("sentinel.dolomites.b4.tif") #red
b8 <- im.import("sentinel.dolomites.b8.tif") #nir

#Mettiamo insieme le 4 bande per comporre un'immagine satellitare
sentdo <- c(b2, b3, b4, b8)


#nir on red,red on green, green on blue
im.plotRGB(sentdo, r=4, g=3, b=2)

#vediamo quanto le barre sono correlate tra loro
pairs(sentdo)

#PCA
pcimage <- im.pca(sentdo)

tot <- sum(1487.78706,  536.25767,   66.98454,   29.66159)
1487.78706*100/tot

#plottiamo questa pca con viridis

vir <- colorRampPalette (viridis (7))(100)
plot(pcimage, col=vir)

#senza dover usare colorRampPalette si può anche fare
plot(pcimage, col=viridis(100))
plot(pcimage, col=plasma(100))


