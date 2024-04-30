#importing data from external sources

#ho scaricato il file eclissi.png nella cartella Download del PC

library(terra)
library(imageRy)

setwd("C:/Users/anisz/Downloads") #spieghiamo al sistema in quale cartella del nostro PC estrarre i dati che vogliamo caricare #wd sta per working directory, molto utilizzato nelle funzioni
#nb x windows: usare il backslash non va bene ad R, bisogna invertire \ con /

#imprting images
eclissi<-rast("eclissi.png") #la funzione crea degli oggetti delle classi SpatRaster #occhio al nome, serve anche l'estensione
eclissi #richiama l'immagine per cui ci escono i dati vari

#plotting data
im.plotRGB(eclissi, 1, 2, 3) #si vede l'immagine; non sappiamo quali siano le bande ma possiamo invertirle per visualizzare l'immagine nelle varie bande

deforestation<-rast("driversdef.jpg") #cos' importo l'altra immagine

#importing images from copernicus
soil<-rast("soil.nc")
plot(soil) #così plotto l'immagine
plot(soil[[1]]) #per plottare solo il primo livello

#crop data
ext<-c(25,30,55,48) #definisco le estensioni xmin xmax, ymin,ymax
soilcrop<-crop(soil,ext) #ottengo una nuova variabile  #NON VA
plot(soilcrop[[1]])