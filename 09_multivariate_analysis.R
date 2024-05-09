#Multivariate analysis

#Richiamiamo i pacchetti
library(terra)
library(imageRy)
library(viridis)

#listiamo
im.list()

#importiamo le singole bande
b2 <- im.import("sentinel.dolomites.b2.tif") #blue       
b3 <- im.import("sentinel.dolomites.b3.tif") #green                    
b4 <- im.import("sentinel.dolomites.b4.tif") #red
b8 <- im.import("sentinel.dolomites.b8.tif") #nir

#Mettiamo insieme le 4 bande per comporre un'immagine satellitare con uno stack
sentdo <- c(b2, b3, b4, b8)

#Facciamo un plot disponiamo l ebande così:
#nir on red,red on green, green on blue
#quindi ciò che riflette il nir (tipo la vegetazione) appare rosso
#la componente rossa appare verde e quella verde appare blu
im.plotRGB(sentdo, r=4, g=3, b=2)

#vediamo quanto le barre sono correlate tra loro
#Si usa l'indice di Pearson che varia da -1 a +1
#le tre bande rossa, blu e verde sono molto correlate tra loro
#il nir non è fortemente correlata con nessuna delle altre 3 bande
#attenzione, correlazione non è causalità
pairs(sentdo)

#Calcoliamo la PCA
pcimage <- im.pca(sentdo)
#la prima riga [1] ci restituisce i range delle varie componenti, il primo che è il + alto
#ci indica la componente principale
#poi nella matrice sottostante vediamo le correlazioni tra le bande originali 
#e le componenti estratte dall'analisi

#Sommiamo i range delle varie componenti per avere la variabilità totale
tot <- sum(1487.78706,  536.25767,   66.98454,   29.66159)

#Calcoliamo la percentuale di variabilità spiegata dalla prima componente 
#dividendola per il totale e moltiplicando il tutto per 100
#Questo lavoro si può fare per ogni componente individuata
1487.78706*100/tot

#Creiamo una colorRampPalette adatta a daltonici usando viridis
vir <- colorRampPalette (viridis (7))(100)
plot(pcimage, col=vir) 

#senza dover usare colorRampPalette si può anche fare
plot(pcimage, col=viridis(100))
plot(pcimage, col=plasma(100))

#La prima immagine PC1 copre molte informazioni e ci restituisce un'immagine simile all'originale
#PC2 e PC3 invece, avendo meno variabilità ci restituiscono immagine meno chiare, di solo rumore
#Quindi grazie alla PCA non dobbiamo scegliere più una banda casuale rischiando che non sia la + informativa
#ma scegliamo la componente + informativa passando da un sistema a 4 dimensioni ad un sistema ad una dimensione

