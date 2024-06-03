#Importing data from external sources

#Come sempre richiamiamo i pacchetti che ci serviranno
library(terra)
library(imageRy)

#Ora spieghiamo al sistema in quale cartella del nostro PC estrarre i dati che vorremo utilizzare
#setwd sta per set working directory
#L'argomento di questa funzione è il percorso della cartella
setwd("/Users/macbookairair/Downloads/Cartella 1/1.png") #perche non va???
#Nell'argomento vanno sempre le virgolette "" perché usciamo da R
#Mai usare il backslash \ ma sempre lo slash normale /

#Importiamo le immagini con terra
eclissi <- rast("eclissi.png") #il nome dell'immagine deve sempre essere corretto
eclissi #richiamandolo vediamo tutti i dati dell'immagine

#Plottiamo l'immagine con i colori originali
im.plotRGB(eclissi, 1, 2, 3) 

#Volendo potrei poi anche giocare con le bande
im.plotRGB(eclissi, 3,2,1)
im.plotRGB(eclissi, 2,3,1)

# Facciamo la differenza tra due bande 
dif=eclissi[[1]] - eclissi[[2]]
plot(dif)

# Importiamo un'altra immagine dall'Earth Observatory
al <- rast("alaska.jpg") 
plot(al) # immagine dell'Alaska

#Ora importiamo il dato scaricato da copernicus sul soil

soil <- rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc") 
plot(soil)
plot(soil[[1]]) #Ci interessa solo la prima banda

#Poi possiamo usare le coordinate per ritagliare le immagini e focalizzarci su un area
#Prima di tutto si definisce un estensione
ext <- c(25,30,55,58) # creo il vettore con l'estensione di x minima e massima e di y minima e massima
soilcrop <- crop(soil, ext) # ora ritaglio l'immagine con la funzione crop

#Ora plotto
plot(soilcrop) # ci dice l' area d'interesse e errore associato
plot(soilcrop[[1]]) # in questo modo non vedo l'errore associato
