#Spectral indices

#come sempre richiamiamo i pacchetti che ci servono
library(terra)
library(imageRy)

#Poi richiamiamo la lista per vedere le immagini disponibili su imageRy
im.list()

#Importiamo l'immagine del 1992 di matogrosso con im.import()
im.import("matogrosso_l5_1992219_lrg.jpg")
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #sempre associando alla funzione un oggetto

#Per quest'immagine le bande erano già montate in questo modo
# banda 1 = nir = R
# banda 2 = red = G
# banda 3 = green = B

#plot RGB
#NIR on red (la vegetazione appare rossa)
im.plotRGB(m1992, r=1, g=2, b=3)

#NIR on green (la vegetazione appare verde)
im.plotRGB(m1992,r=2, g=1, b=3) #sposto la banda 1 che è la banda nir sul filtro del verde 
#la parte rosa è il suolo nudo che è poco rispetto alla fortesta, quindi si ha poco impatto umano

#NIR on blue (la vegetazione appare blu)
im.plotRGB(m1992, r=2, g=3, b=1) #sposto la banda 1 che è la banda nir sul filtro blu
#in questo modo il suolo nudo diventa giallo il che è più evidente per l'occhio umano


#matogrosso 2006
#vediamo se la situazione si è modificata in 14 anni
#importiamo l'immagine e associamola ad un oggetto
im.import("matogrosso_ast_2006209_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

#anche per quest'immagine vediamo
#nir on red
im.plotRGB(m2006, r=1, g=2, b=3)

#nir on green
im.plotRGB(m2006, r=2, g=1, b=3)

#nir on blue
im.plotRGB(m2006, r=2, g=3, b=1)

#mettiamo le immagini nir on red del 1992 e del 2006 vicine con un multiframe
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

dev.off()

#mettiamo ora tutte e 6 le immagini insieme
#nella prima riga le 3 immagini del 1992
#nella seconda riga le 3 immagini del 2006 in modo da apprezzare meglio l'impatto antropico
par(mfrow=c(2,3))
im.plotRGB(m1992, r=1, g=2, b=3) #1992 on red
im.plotRGB(m1992,r=2, g=1, b=3) #1992 on green
im.plotRGB(m1992, r=2, g=3, b=1) #1992 on blue
im.plotRGB(m2006, r=1, g=2, b=3) #2006 on red
im.plotRGB(m2006, r=2, g=1, b=3) #2006 on green
im.plotRGB(m2006, r=2, g=3, b=1) #2006 on blue


#Calculating DVI
dvi1992 = m1992[[1]] - m1992 [[2]]

#plotting the DVI
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi1992, col= cl)

#2006
dvi2006 = m2006[[1]] - m2006 [[2]]

#Exercise: plot the dvi1992 beside the dvi2006
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi1006, col=cl)

#stacksent
stackdvi <- c(dvi1992, dvi2006)
pairs(stackdvi)

#Normalized DVI
#essendo un'operazione metto = ma potevoi anche usare l'assegnazione <-
ndvi1992 = dvi1992/(m1992[[1]]+m1992[[2]])

ndvi2006 = dvi2006/(m2006[[1]]+m2006[[2]])

dev.off()
par(mfrow= c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)
