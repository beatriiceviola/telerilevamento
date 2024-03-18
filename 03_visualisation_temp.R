#Satellite data visualisation in R by imageRy

library(terra)
library(imageRy)

#List of data avialable in imageRy
im.list()

#Importing data banda del blu
#assegno un oggetto alla mia funzione im.import
b2<- im.import("sentinel.dolomites.b2.tif" )
#Plotting the data
plot(b2)

#Cambiamo scala dei colori 
colorRampPalette(c("cyan4","magenta","cyan", "chartreuse"))(100)
#assegniamo un oggetto alla funzione
clch<-colorRampPalette(c("cyan4","magenta","cyan", "chartreuse"))(100)

#Plotting the data
plot(b2, col= clch)

#Importing the additional bands 
#banda del verde
b3 <- im.import("sentinel.dolomites.b3.tif")  
plot(b3, col=clch)
#banda del rosso
b4<-im.import("sentinel.dolomites.b4.tif")
plot(b4, col=clch)
#banda del vicino infrarosso
b8 <- im.import("sentinel.dolomites.b8.tif")  
plot(b8, col=clch)
                         
#multiframe
#row sono le righe (2 nell'esempio) seguite dalle colonne (sempre 2) che posso scegliere io
#si tratta sempre di un array quindi usiamo la funzione concatenate
par(mfrow=c(2,2))
plot(b2, col= clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)

#Exercise plot the four bands one after the other in one single row

par(mfrow=c(1,4))
plot(b2, col= clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)

#Uniamo le 4 bande in una sola immagine satellitare?
#Prima associamo alla funzione concatenate un oggetto
stacksent<-c(b2,b3,b4,b8)
#poi lo plottiamo
plot(stacksent, col=clch)
#mettiamo tra parentesi quadre????
plot(stacksent[[4]], col=clch)

#Se voglio cancellare l'immagine plottata uso la funzione
dev.off()

#stacksent[[1]]= b2= blue
#stacksent[[2]]= b3= green
#stacksent[[3]]= b4= red
#stacksent[[4]]= b8= nir

#RGB plotting

#im.plotRGB(stacksent, r=3, g=2, b=1 ) plotto l'immagine con colori naturali
im.plotRGB(stacksent, 3, 2, 1 )

#plottiamo l'immagine con l'infrarosso al posto del rosso
im.plotRGB(stacksent, 4, 2, 1 )

#multiframe
par(mfrow=c(1,2))
im.plotRGB(stacksent, 3, 2, 1 )
im.plotRGB(stacksent, 4, 2, 1 )
im.plotRGB(stacksent, 4, 3, 2 )

#nir on green
im.plotRGB(stacksent, 3, 4, 2 )

#nir on blue
im.plotRGB(stacksent, 3, 2, 4 )

#Final multiframe
par(mfrow=c(2,2))
im.plotRGB(stacksent, 3, 2, 1 )
im.plotRGB(stacksent, 4, 2, 1 )
im.plotRGB(stacksent, 3, 4, 2 )
im.plotRGB(stacksent, 3, 2, 4 )

#correlations of information
pairs(stacksent)
