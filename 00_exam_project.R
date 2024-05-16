#Richiamo i pacchetti che andrò ad utilizzare
library(terra) #per la funzione rast
library(ggplot2) #per costruire grafici
library(viridis) #per avere una colorRampoPalette adatta ai daltonici
library(imageRy) #per la funzione im.classify()


#Il progetto riguarda una zona di riforestazione nei dintorni di Miguel Pereira in Brasile
#Dopo gli incendi del 2014 sono stati ripiantati più di 60 mila alberi tra il 2018 e il 2021
#Osserviamo gli effetti di questa riforestazione
#Le immagini sono state prese da Copernicus Browser
#Iniziamo cambiando la nostra work directoy da cui R prenderà i dati che ci servono
setwd("/Users/macbookairair/Downloads/Progetto R")

#Scegliamo una colorRampPalette inclusiva per i daltonici
cl<-colorRampPalette(viridis(7))(255) 

#Ora andiamo a prendere dalla nostra cartella l'immagine che ci serve
#Le immagini sono state fatte da Sentinel-2
#Le bande sono già decise
#Prima importiamo le immagini con colori naturali
#banda 1 = R = red
#banda 2 = G = green
#banda 3 = B = blue
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
#sempre bande già decise da Sentinel-2
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

#Calcoliamo il Difference Vegetation Index normalizzato , NDVI che varia da 1 a -1
#NDVI= (NIR-red)/(NIR+red)
NDVI2017 <- (fc2017[[1]]-fc2023[[2]])/(fc2017[[1]]+fc2023[[2]])
