#Richiamo i pacchetti che andrò ad utilizzare
library(terra) #per la funzione rast
library(ggplot2) #per costruire grafici
library(viridis) #per avere una colorRampoPalette adatta ai daltonici
library(imageRy) #per la funzione im.classify()
library(patchwork) #per unire i grafici

#Il progetto riguarda una zona di riforestazione nei dintorni di Miguel Pereira in Brasile
#Dopo gli incendi del 2014 sono stati ripiantati più di 60 mila alberi tra il 2018 e il 2021
#Osserviamo gli effetti di questa riforestazione
#Le immagini sono state prese da Copernicus Browser
#Iniziamo cambiando la nostra work directoy da cui R prenderà i dati che ci servono
setwd("/Users/macbookairair/Downloads/Progetto R")

#Ora andiamo a prendere dalla nostra cartella l'immagine che ci serve
#Le immagini sono state fatte da Sentinel-2
#Le bande sono già decise
#Prima importiamo le immagini con colori naturali true colors=tc
#banda 1 = R =
#banda 2 = G =
#banda 3 = B =
suppressWarnings({
tc2017 <- rast("tc.sept2017.300m.jpg")
})
suppressWarnings({
tc2023 <- rast("tc.sept2023.300m.jpg")
})

#Mettiamo le 2 immagini vicine per poter fare un confronto diretto, quindi 1 riga e 2 colonne
par(mfrow=c(1,2))
plot(tc2017)
plot(tc2023)
dev.off()

#Importiamo ora le stesse immagini con falsi colori
#Bande già decise da Sentinel-2
#banda 1 = R = NIR
#banda 2 = G = red
#banda 3 = B = green
suppressWarnings({
fc2017 <- rast("fc.sep2017.jpg")})
suppressWarnings({
fc2023 <- rast("fc.sep2023.jpg")
})

#Mettiamole vicine
par(mfrow=c(1,2))
plot(fc2017)
plot(fc2023)
dev.off()

#Facciamo un plot RGB per visualizzare meglio l'immagine
#2017
im.plotRGB(fc2017, r=1, g=2 , b=3) #NIR on red, la vegetazione apparirà rossa e il suolo nudo azzurrino 
im.plotRGB(fc2017, r=1, g=2 , b=3) #NIR on green, veg= verde, suolo nudo= rosino

#Facciamo la stessa cosa per il 2023
im.plotRGB(fc2023, r=1, g=2 , b=3) 
im.plotRGB(fc2023, r=1, g=2 , b=3)

#Facciamo un multiframe
par(mfrow=c(2,2)) # multiframe 2 righe e 3 colonne
im.plotRGB(fc2017, 1, 2, 3) # NIR on R
im.plotRGB(fc2023, 1, 2, 3) # NIR on R
im.plotRGB(fc2017, 2, 1, 3) # NIR on G
im.plotRGB(fc2023, 2, 1, 3) # NIR on G


#Scegliamo una palette di colori (rosso, rosa verde in modo che la vegetazione appaia sempre verde e il suolo nudo rosino)
cold <- colorRampPalette(c("tomato4", "lightpink", "olivedrab")) (100)

#DVI e NDVI
#Calcoliamo la DVI, Difference Vegetation Index (DVI= NIR-red)
#2017
dvi2017 <- (fc2017[[1]]-fc2017[[2]])
plot(dvi2017, col=cold)

#2023
dvi2023 <- (fc2023[[1]]-fc2023[[2]])
plot(dvi2023, col=cold)

#Calcoliamo la Normalized Difference Vegetation Index NDVI che varia da 1 a -1
#NDVI= (NIR-red)/(NIR+red)
#2017
ndvi2017 = dvi2017/(fc2017[[1]]+fc2017[[2]])
#Plottiamo usando la palette usata prima
plot(ndvi2017, col=cold)
dev.off()

#Calcoliamo la NDVI per il 2023
ndvi2023 = dvi2023/(fc2023[[1]]+fc2023[[2]])
plot(ndvi2023, col=cold) 

#Creiamo uno stacksent per la NDVI nei 2 anni
stacksent <- c(ndvi2017, ndvi2023)
plot(stacksent, col=cold)

#Valutiamo la correlazione tra le due immagini
pairs(stacksent) #COME SI VALUTA?????

#Dalle due immagini vicine riusciamo a vedere come nel 2023 la vegetazione (che appare verde)
#sia aumentata, ma come facciamo a capirlo non solo qualitativamente ma anche qunatitativamente?

#CLASSIFICAZIONE ???? meglio su fc2017 o su ndvi2017????
#Classifichiamo con 2 cluster le immagini
#2017
class17 <- im.classify(ndvi2017, num_clusters=2)
class.names <- c("foresta", "suolo nudo")
#Plottiamo dando un titolo all'immagine e un nome all classi
plot(class17, main= "Classificazione 2017", type="classes", levels= class.names)

#2023
class23 <- im.classify(ndvi2023, num_clusters=2)
class.names <- c("foresta", "suolo nudo")
plot(class23, main= "Classificazione 2023", type="classes", levels=class.names)

#Calcoliamo la frequenza dei pixel presenti in una classe
#e quella dei pixel presenti nell'altra
#2017
freq17 <- freq(class17)
freq17
#Calcoliamo il totale dei pixel
tot17 <- ncell (class17)
tot17
#Proporzione
prop17 = freq17/tot17
prop17
#Percentuale 
#Foresta = 51%
#Suolo nudo= 49%
perc17 = prop17*100
perc17

#Facciamo la stessa cosa per il 2023
freq23 <- freq(class23)
freq23
tot23 <- ncell(class23)
tot23
prop23 = freq23/tot23
prop23
#Foresta= 61%
#Suolo nudo= 39%
perc23 = prop23*100
perc23 

#Calcoliamo ora la differenza ???? non capisco che significa
diff_nir = fc2017[[1]] - fc2023[[1]]
cl <- colorRampPalette(c("red","white","blue"))(100)
plot(diff_nir, col=cl)
