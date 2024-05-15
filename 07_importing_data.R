#Importing data from external sources

#Come sempre richiamiamo i pacchetti che ci serviranno
library(terra)
library(imageRy)

#Ora spieghiamo al sistema in quale cartella del nostro PC estrarrei dati che vorremo utilizzare
#setwd sta per set working directory
#L'argomento di questa funzione è il percorso della cartella
setwd("/User/") 
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
#Da qui va ancora modificato
nz <- rast("nz.jpg") # stessa cosa fatta prima???
plot(nz) # immagine della Nuova Zelanda????

# importiamo il dato scaricato da copernicus sul soil

soil <- rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc") # sempre il nome dell'immagine di com'è salvata nel pc
plot(soil)
plot(soil[[1]]) # solo il primo livello che ci interessa

## possiamo usare le coordinate per ritagliare le immagini e focalizzarci su un area

# prima di tutto si definisce un estensione
# prima si da la X minima e X massima e la Y min e max

ext <- c(25,30,55,58) # creo il vettore con l'estensione di X (primi due numeri) e Y (terzo e quarto numero)
soilcrop <- crop(soil, ext) # taglio l'immagine nell'estensione individuata con la funzione crop
plot(soilcrop) # area d'interessse e errore associato
plot(soilcrop[[1]]) # solo della prima banda, la nostra variabile d'interesse senza l'errore associato
# se mantieni sempre le stesse coordinate puoi usarlo anche per diverse immagini sulla stessa area di studio
