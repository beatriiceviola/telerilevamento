#Visualizziamo immagini 

library(terra) #richiamo i pacchetti che mi servono, senza virgolette perché li abbimao già scaricati
library(imageRy)

#Usiamo la funzione di imageRy im.list()
#questa ci fornisce la lista dei dati che abbiamo che sono già caricati nel pacchetto
#ogni funzione del pacchetto imageRy inizia con im.
im.list()

#Importiamo un'immagine della lista con la funzione im.import("")
#in particolare l'immagine b2 da Sentinel che è la banda che corrisponde alla lunhgezza d'onda del blu
im.import("sentinel.dolomites.b2.tif")
#e ora ssegniamogli un oggetto
b2 <- im.import("sentinel.dolomites.b2.tif")

#Plot
#dopo averla importata la plottiamo per la visualizzazione
plot(b2)

#Ora possiamo cambiare la scala dei colori e lo facciamo con la funzione colorRampPalette()
#trattandosi di più colori vado a concatenarli con la funzione concatenate c()
#ogni colore deve essere messo tra virgolette
#per finire la funzione specifico il numero di sfumature che voglio, nell'esempio (100)
colorRampPalette(c("cyan4","magenta","cyan", "chartreuse"))(100)

#assegniamo un oggetto alla funzione
clch<-colorRampPalette(c("cyan4","magenta","cyan", "chartreuse"))(100)

#Plottiamo l'immagine con i nuovi colori
plot(b2, col= clch)

#Importiamo ora le altre immagini corrispondenti ad altre tre bande
#in particolare
#banda del verde
b3 <- im.import("sentinel.dolomites.b3.tif")  
plot(b3, col=clch)
#banda del rosso
b4<-im.import("sentinel.dolomites.b4.tif")
plot(b4, col=clch)
#banda del vicino infrarosso
b8 <- im.import("sentinel.dolomites.b8.tif")  
plot(b8, col=clch)
                         
#Creiamo ora un multiframe che ci permette di visualizzare tutte e 4 le immagini insieme
#Per fare ciò usiamo la funzione par()
#row sono le righe (2 nell'esempio) seguite dalle colonne (sempre 2) che posso scegliere io
#le righe vanno sempre prima delle colonne in questa funzione
#si tratta sempre di un array quindi usiamo la funzione concatenate
par(mfrow=c(2,2))

#questa funzione crea la cornice (che nel nostro esempio è 2x2)
#e ora dobbiamo inserire all'interno di questa cornice le nostre immagini
#quindile plottiamo tutte e 4 di nuovo
plot(b2, col=clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)

#Esercizio: polttare le 4 immagini in una sola righa
par(mfrow=c(1,4)) #Essendo 4 immagini per avere una sola riga dovrò avere 4 colonne
plot(b2, col= clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)

#STACKSENT??????
#Prima creiamo un vettore con le nostre 4 bande grazie alla funzione concatenate
#e poi lo associamo ad un oggetto
stacksent<-c(b2,b3,b4,b8)
#poi lo plottiamo
plot(stacksent, col=clch)
#sebbene sia più rapido del par() usato prima,
#in questo caso il multiframe è sempre di 2x2 ???????????

#Se voglio cancellare l'immagine plottata uso la funzione
dev.off()

#Immaginiamo di voler vedere una sola banda, ad esempio la quarta
#ovvero quella dell'infrarosso
#Per farlo specifico che dal mio array prendo solo il quarto oggetto 
#mettendolo in una doppia parentesi quadra
#doppia perché l'immagine è in 2 dimensioni
plot(stacksent[[4]], col=clch)

#Creiamoci per comodità un indice che ci dica a quali elementi dello stacksent
#corrispondono quali bande
#stacksent[[1]]= b2= blue
#stacksent[[2]]= b3= green
#stacksent[[3]]= b4= red
#stacksent[[4]]= b8= nir

#RGB plotting
#RGB sono i 3 filtri (red, green, blue)
#Per plottare un'immagine RGB usiamo la funzione di imageRy
#im.plotRGB(), all'interno delle parentesi specifico qual è l'oggetto con le mie bande
#nel nostro caso stacksent,e poi sepcifico su quale filtro voglio mettere quale banda

#Ad esempio 
#im.plotRGB(stacksent, r=3, g=2, b=1 ) plotto l'immagine con colori naturali
#perché so che nel mio stacksent 3 è l abanda del rosso e la lascio sul filtro rosso
#2 è la banda del verde e la lascio sul filtro verde
#1 è l abanda blu e la lascio sul filtro blu
im.plotRGB(stacksent, 3, 2, 1 ) #per semplicità posso anche evitare di scrivere r=, g= e b=

#plottiamo l'immagine con l'infrarosso al posto del rosso
#nir on red
#quindi tutto ciò che riflette l'infrarosso, come l avegetazione, ora lo visualizzo rosso
im.plotRGB(stacksent, 4, 2, 1 )

#oppure con l'infrarosso al posto del verde
#nir on green
im.plotRGB(stacksent, 3, 4, 2 )

#o ancora sul blu
#nir on blue
im.plotRGB(stacksent, 3, 2, 4 )


#multiframe
par(mfrow=c(1,3))
im.plotRGB(stacksent, 3, 2, 1 ) #immagine naturale
im.plotRGB(stacksent, 4, 2, 1 ) #nir on red
im.plotRGB(stacksent, 4, 3, 2 ) #immagine a falsi colori

dev.off()

#Final multiframe
par(mfrow=c(2,2))
im.plotRGB(stacksent, 3, 2, 1 ) #colori naturali, come li vedrebbero i nostri occhi
im.plotRGB(stacksent, 4, 2, 1 ) #nir on red
im.plotRGB(stacksent, 3, 4, 2 ) #nir on green
im.plotRGB(stacksent, 3, 2, 4 ) #nir on blue
#notiamo quanto l'infrarosso vicino ci restituisca molta informazione

#correlations of information
pairs(stacksent)
#ci fa vedere che l'infrarosso non è correlato alle altre bande, mentre le altre bande sono ben correlate tra loro
#questo ci fa capire perché l'infrarosso aggiunge informazioni
