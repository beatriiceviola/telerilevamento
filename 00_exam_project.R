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

#Ora andiamo a prendere dalla nostra cartella l'immagine che ci serve
#Le immagini sono state fatte da Sentinel-2
#Le bande sono già decise
#Prima importiamo le immagini con colori naturali
#banda 1 = R = red
#banda 2 = G = green
#banda 3 = B = blue

#Scegliamo una colorRampPalette inclusiva per i daltonici
cl<-colorRampPalette(viridis(7))(255) 

suppressWarnings({
tc2017 <- rast("tc.sept2017.300m.jpg")
})
suppressWarnings({
tc2023 <- rast("tc.sept2023.300m.jpg")
})

#Mettiamo le 2 immagini vicine per poter fare un confronto diretto, quindi 1 riga e 2 colonne
par(mfrow=c(1,2))
plot(tc2017, col=cl)
plot(tc2023, col=cl)
