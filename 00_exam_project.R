#Richiamo i pacchetti che andrò ad utilizzare
library(terra) #per la funzione rast
library(ggplot2) #per costruire grafici
library(viridis) #per avere una colorRampoPalette adatta ai daltonici
library(imageRy) #per la funzione im.classify(), im.pca() e im.plotRGB()
library(patchwork) #per unire i grafici

#Il progetto riguarda una zona di riforestazione nei dintorni di Miguel Pereira in Brasile
#Dopo gli incendi del 2014 sono stati ripiantati più di 600 mila alberi tra il 2018 e il 2021
#Osserviamo gli effetti di questa riforestazione
#Le immagini sono state prese da Copernicus Browser
#Iniziamo cambiando la nostra work directoy da cui R prenderà i dati che ci servono
setwd("/Users/macbookairair/Downloads/Progetto R")

#Ora andiamo a prendere dalla nostra cartella l'immagine che ci serve
#Le immagini sono state fatte da Sentinel-2
#Le bande sono già decise
#Prima importiamo le immagini con colori naturali true colors=tc
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
im.plotRGB(fc2017, r=1, g=2 , b=3) #NIR on red, veg= rossa, suolo nudo= azzurrino
im.plotRGB(fc2017, r=2, g=1 , b=3) #NIR on green, veg= verde, suolo nudo= rosino

#Facciamo la stessa cosa per il 2023
im.plotRGB(fc2023, r=1, g=2 , b=3) 
im.plotRGB(fc2023, r=2, g=1 , b=3)

#Facciamo un multiframe
par(mfrow=c(2,2)) # multiframe 2 righe e 3 colonne
im.plotRGB(fc2017, 1, 2, 3) # NIR on R
im.plotRGB(fc2023, 1, 2, 3) # NIR on R
im.plotRGB(fc2017, 2, 1, 3) # NIR on G
im.plotRGB(fc2023, 2, 1, 3) # NIR on G

#Scegliamo una palette di colori 
#(rosso, rosa verde in modo che la vegetazione appaia sempre verde e il suolo nudo rosino)
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
#La usiamo perché è un indice normalizzato che ci fornsice valori standardizzati che possono
#essere di più facile interpretazione e possono essere usati per confrontare immagini
#di dimensioni diverse 
#NDVI= (NIR-red)/(NIR+red)
#2017
ndvi2017 = dvi2017/(fc2017[[1]]+fc2017[[2]])
#Plottiamo usando la palette usata prima
plot(ndvi2017, col=cold)
dev.off()

#Calcoliamo la NDVI per il 2023
ndvi2023 = dvi2023/(fc2023[[1]]+fc2023[[2]])
plot(ndvi2023, col=cold) 

#Dalle due immagini vicine riusciamo a vedere come nel 2023 la vegetazione (che appare verde)
#sia aumentata, ma come facciamo a capirlo non solo qualitativamente ma anche qunatitativamente?

#CLASSIFICAZIONE 
#Classifichiamo con 2 cluster le immagini
#2017
class17 <- im.classify(ndvi2017, num_clusters=2)
class.names <- c("suolo nudo", "foresta")
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

#Calcoliamo ora la differenza tra la banda del NIR del 2017 e quella del 2023
#è una differenza negativa perché aumentando la vegetazione aumenta la riflettanza del NIR
#Quindi le parti in rosso sono quelle dove la vegetazione è aumentata
#(se avessi fatto 2023-2017 sarebbe stata una differenza positiva
#e la vegetazione in più sarebbe apparsa blu)
diff_nir = fc2017[[1]] - fc2023[[1]]
cl <- colorRampPalette(c("red","white","blue"))(100)
plot(diff_nir, col=cl)

#CREIAMO UN DATAFRAME E UN GRAFICO
#Per prima cosa andiamo a creare una tabella per confrontare 
#come variano le frequenze delle due classi nei due anni

class <- c("foresta","suolo nudo") #Prima colonna
y2017 <- c(51,49) #Seconda
y2023 <- c(61,39) #Terza

tabout <- data.frame(class, y2017, y2023)
tabout #Visualizziamo il dataframe

#Creiamo ora i grafici con ggplot
#2017
ggplot(tabout, aes(x=class, y= y2017, color=class)) + 
geom_bar(stat="identity", aes(fill= class), width= 0.7)+
ylim(c(0,100)) +
ggtitle("Area d'indagine nel 2017") + xlab("Classi") + ylab("Valori percentuali")+
theme(plot.title = element_text(face = "bold", hjust = 0.5)) 

#2023
ggplot(tabout, aes(x=class, y=y2023, color=class)) + 
geom_bar(stat="identity",aes(fill= class), width= 0.7)+        
ylim(c(0,100))+
ggtitle("Area d'indagine nel 2023") + xlab("Classi") + ylab("Valori percentuali")+
theme(plot.title = element_text(face = "bold", hjust = 0.5)) 

#Visualizziamo i due grafici insieme con patchwork
p1 <-ggplot(tabout, aes(x=class, y=y2017, color=class)) + geom_bar(stat="identity", aes(fill=class), width= 0.7)+ ylim(c(0,100))+ggtitle("Area d'indagine nel 2017") + xlab("Classi") + ylab("Valori percentuali")+
theme(plot.title = element_text(face = "bold", hjust = 0.5)) 
p2 <-ggplot(tabout, aes(x=class, y=y2023, color=class))+ geom_bar(stat="identity", aes(fill=class),width= 0.7)+ ylim(c(0,100))+ggtitle("Area d'indagine nel 2023") + xlab("Classi") + ylab("Valori percentuali")+
theme(plot.title = element_text(face = "bold", hjust = 0.5)) 
p1 + p2

dev.off

#CALCOLIAMO LA DEVIAZIONE STANDARD SULLA BANDA DEL NIR
#2017
nir17 <- fc2017[[1]]
plot(nir17)
sd7 <- focal(nir17, matrix(1/9, 3, 3), fun=sd)
plot(sd7, col=viridis(100))

#2023
nir23 <- fc2023[[1]]
plot(nir23)
sd3 <- focal(nir23, matrix(1/9, 3, 3), fun=sd)
plot(sd3, col=viridis(100))

#Creiamo uno stacksent sulle due immagini true colors per poi vedere 
#con pairs il livello di correlazione
#e quindi valutare se è possibile fare o meno una PCA
stack17 <- c(tc2017[[1]], tc2017[[2]], tc2017[[3]]) 
plot(stack17, col=cold)

#Valutiamo la correlazione tra le bande del 2017
pairs(stack17) 

#FAcciamo la stessa cosa per il 2023
stack23 <- c(tc2023[[1]], tc2023[[2]], tc2023[[3]])
plot(stack23, col=cold)
pairs(stack23)

#CALCOLIAMO LE COMPONENTI PRINCIPALI
#2017
pcimage17 <- im.pca(tc2017)
tot <- sum(44.124839, 7.201212, 5.136439)

#tot pc1 78%
44.124839*100/tot 
#tot pc2 13%
7.201212*100/tot
#tot pc3 9%
5.136439*100/tot

#2023
pcimage23 <- im.pca(tc2023)
total <- sum(38.364531, 7.559969, 4.076665)
#tot pc1 77%
38.364531*100/total
#tot pc2 15%
7.559969*100/total
#tot pc3 8%
4.076665*100/total

#Ora che, invece, usiamo la tecnica della moving window sulla PC1
#che è la più rappresentativa (invece che calcolarla su una banda scelta da noi)
#2017
pc17<-pcimage17$PC1
pc17.sd7<-focal(pc17, matrix(1/9, 3, 3), fun=sd)
plot(pc17.sd7, col=viridis(100))

#2023
pc23 <-pcimage23$PC1
pc23.sd3<-focal(pc23, matrix(1/9, 3, 3), fun=sd)
plot(pc23.sd3, col=viridis(100))

#Facciamo uno stack
stack <- c(sd3, sd7, pc17.sd7, pc23.sd3)
plot(stack, col=viridis(100))
