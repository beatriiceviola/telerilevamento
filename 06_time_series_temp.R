#Second method to quantify changes in time
#The first method was based on classification

#Richiamiamo sempre i pacchetti che ci servono
library(terra)
library(imageRy) 

#Facciamo la lista delle immagini disponibili su imageRy
im.list()

#Importimao le immagini dell'European Nitrogen
EN01<- im.import("EN_01.png") #gennaio 2020
EN13<- im.import("EN_13.png") #marzo 2020, durante la pandemia del covid
#anche se la rainbow color non è bellissima non possiamo modificarla perché sono immagini già elaborate

#Mettiamo le due immagini una sopra l'altra, quindi 2 righe e 1 colonna
par(mfrow=c(2,1))

#Con la funzione im.plot.RGB.auto() vengono usate direttamente le prime 3 bande
#a differenza di im.plot.RGB() in cui vanno specificate le bande che voglio usare
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

dev.off() #Ogni tanto è bene "ripulire" tutto

#Posso ora fare la differenza tra le stesse bande delle 2 immagini (per ogni pixel)
#facciamo la differenza tra la prima banda di EN01 e della prima banda di EN13
#Essendo una formula matematica posso mettere = anziché <- per fare l'associazione
difEN = EN01[[1]]-EN13[[1]]

#Faccio una colorRampPalette e metto il rosso come massimo così che corrisponda alla temperatura + alta
cl<- colorRampPalette(c("blue", "white", "red"))(100)

#Ora plotto la mia differenza con i colori scelti
#In questo modo otteniamo una quantificazione del cambiamento, essendo immagini a 8 bit può
#variare da -255 a +255
plot(difEN, col=cl)

##Ice melt in Greenland
#Prendiamo dati ottenuti da Copernicus che sono a 16 bit, molto informativi
#il range però non arriva a 65000 ma attorno ai 15000
#Usiamo un proxy, quindi non usiamo direttamente il ghiaccio 
#ma un parametro che lo rappresenta ovvero l atemperatura del suolo

#associazione oggetto/funzione 
g2000<- im.import("greenland.2015.tif") #2000
clg<-colorRampPalette(c("black", "blue", "white", "red"))(100) #cambio la scala dei colori
plot(g2000, col=clg) #Plottiamo l'immagine con i nuovi colori, il nero è la temperatura + bassa

#Importo le altre immagini
g2005<- im.import("greenland.2005.tif") #2005
g2010<- im.import("greenland.2010.tif") #2010
g2015<- im.import("greenland.2015.tif") #2015

#Metto tutte e 4 le immagini dal 2000 al 2015 vicine in 2 rige e 2 colonne
par(mfrow=c(2,2))
plot(g2000, col=clg)
plot(g2005, col=clg)
plot(g2010, col=clg)
plot(g2015, col=clg)

dev.off()

#Oppure invece che usare la funzione par() posso fare uno stack
#con lo stack trasformo le immagini in bande di una stessa immagine??????????
greenland <-c(g2000,g2005,g2010,g2015)
plot(greenland, col=clg)

#Differenza tra immagini usando lo stack appena creato
#in questo modo faccio una differenza tra il 2000 (1) e il 2015(4)
difg = greenland [[1]]- greenland[[4]]
clgreen<-colorRampPalette(c("red", "white", "blue"))(100) #il rosso indica dove la temperatura è aumentata
plot(difg, col=clgreen) #plotto la differenza

#Associo ad ogni componente dell'RGB un' immagine, ne posso usare 3 ovviamente
#2000 sulla banda del rosso, 2005 sul verde e 2015 sul blu
im.plotRGB(greenland, r=1, g=2, b=4)
#con il rosso vedo le T più alte nel 2000
#con il verde quelle del 2005
#con il blu quelle del 2015
#Ovviamente possousarlo solo per immagini uguali



