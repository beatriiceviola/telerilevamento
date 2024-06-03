#Measuring spatial variability 

#Importiamo i pacchetti
library(imageRy)
library(terra)

#Facciamo la lista dei dati disponibili
im.list()

#Importiamo un'immagine di Sentinel
sent <- im.import("sentinel.png")

#Plottiamo l'immagine senza modificare l'ordine delle bande
im.plotRGB (sent, r=1, g=2, b=3) #la vegetazione riflette il nir e appare rossa

#nir = band 1 
#red = band 2
#green = band 3

#nir on green
im.plotRGB (sent, r=2, g=1, b=3) #la vegetazione appare verde

#Calcoliamo la deviazione standard su una banda che scegliamo noi
nir <- sent[[1]]  #associo la prima banda ad un oggetto
cl <- colorRampPalette(c("red","orange","yellow"))(100) #cambio la scala dei colori
plot(nir, col=cl) #plotto l'immagine

#Per calcolarla usiamo la funzione focal() che usa una moving window
#all'interno di focal specifichiamo:
#l'immagine con la banda d'interesse (la prima nel nostro caso)
#poi una matrice (che è un vettore in 2 dimensioni) che serve per creare la moving window
#voglio usare una finestra 3x3 pixel
#nell'argomento della matrice specifico (1/9= uso tutti e 9 i pixel della matrice, 3= righe,3= colonne)
#infine definisco la funzione che voglio usare con fun (sd= standard deviation)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

#installiamo un nuovo pacchetto che ci permette di usare colori adatti anche ai daltonici
install.packages("viridis")
library(viridis) #e poi richiamiamolo

#Facciamo una colorRampPalette, non serve specificare i colori 
#perché usiamo quelli già disponibili su viridis
viridisc <- colorRampPalette(viridis(7))(256) 
#7 è il settimo blocco che è quello che ci interessa, va sempre specificato
plot(sd3, col= viridisc) #plottiamo la deviazione standard con questi nuovi colori

#Calcoliamo la deviazione standard di una finestra 7x7
sd7 <- focal (nir, matrix(1/49,7,7), fun=sd) #righe e colonne sono 7, window totale ha 49 pixel
plot(sd7, col=viridisc) 
#la deviazione standard è più grande perché prendiamo un'area più grande con questa finestra

#Calcoliamo la deviazione standard di una finestra 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)#righe e colonne sono 13, window totale ha 169 pixel
plot(sd13, col= viridisc)

#Con finestre più grandi ho immagini meno risolute
#come faccio a scegliere di che dimensioni usare la finestra?
#Non c'è un modo giusto per farlo, devo fare + prove con finestre diverse e scegliere la + adatta
#Con uno stacksent plotto le 3 immagini insieme
sdstack <- c(sd3, sd7, sd13) #creo lo stack
plot(sdstack, col=viridisc) #plotto 
