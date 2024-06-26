#Quantifying land cover change

#Installiamo i pacchetti che ci servono
install.packages("ggplot2") #ggplot2 ci permette di fare dei grafici più belli

#Chiamiamoli con la funzionelibrary 
library(terra)
library(imageRy)
library(ggplot2)

#Facciamo una lista delle immagini disponibili
im.list()

#Importiamo l'immagine che ci interessa 
#questa volta si tratta di un immagine del Sole del satellite Solar Orbiter
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") 

#Classifichiamo le immagini con la funzione im.classify()
#il primo argomento è l'immagine che vogliamo classificare
#il secondo è il numero di cluster che vogliamo per quest'immagine
im.classify(sun, num_clusters=3)

#Importiamo le immagini del 1992 e 2006 del Matogrosso
#sempre associandole ad un oggetto
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") 
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

#Classifichiamole 
#Alcuni pixel non sono immediatamente riconducibili ad una classe o ad un'altra
#Per questo può succedere che riplottando queste funzioni il risultato cambii leggermente
#1992
#qui scegliamo 2 clusters anziché 3 come prima
m1992c <- im.classify(m1992, num_clusters=2)

#1992
#Le classi 1 e 2 sono casuali, quindi mi scrivo a quale classe corrisponde cosa
#class 1 = human
#class 2 = forest

#2006
m2006c <- im.classify (m2006, num_clusters=2)

#2006
#Ad esempio per il 2006 le due classi si sono invertite, sempre casualmente
# class 1 = forest
# class 2 = human

#Calcoliamo le frequenza di suolo nudo e di foresta 
#questa funzione mi permette di quantificare il numero di pixel appartenente
#ad una classe (foresta) e il numero di pixel appartenente all'altra (suolo nudo)

#frequenze 1992 
f1992 <- freq(m1992c) 
f1992 #richiamando l'oggetto ho il numero di pixel delle 2 classi per matogrosso1992

# Calcoliamo la proporzione, per farlo ci serve il numero totale di pixel
#si ottiene usando la funzione ncell(), tra parentesi mettiamo l'immagine di 
#cui ci interessa conoscere il numero total edi pixel
tot1992 <- ncell(m1992c)
tot1992
#tot= 1800000

#Ora per avere la proporzione vera e propria facciamo la frequenza diviso il totale
prop1992 = f1992/tot1992
prop1992 #la colonna count è quella che ci interessa

#Per avere le percentuali moltiplico la mia proporzione per 100
perc1992 = prop1992 * 100
perc1992
#17% human, 83% forest

#Calcolo le frequenze come prima anche per Matogrosso 2006
f2006 <- freq(m2006c)
f2006

#Totale pixel 
tot2006 <- ncell(m2006c)
tot2006 
#tot= 7200000

#Proporzioni= frequenza diviso il totale
prop2006 = f2006/tot2006
prop2006

#Percentuali, moltiplico le proporzioni per 100
perc2006 = prop2006 * 100
perc2006
#55% human, 45% forest

#Creiamo un dataframe che contiene righe e colonne 
#All'interno di queste inseriremo i nostri dati
#In particolare creiamo 3 vettori, ognuno di questi vettori diventerà
#una colonna nella nostra tabella
class <- c("forest", "human") # la prima colonna è la classe
p1992 <- c(83, 17) #la seconda sono i valori percentuali del 1992 per ogni classe
p2006 <- c(45, 55) #la terza colonna sono i valori percentuali del 2006 per ogni classe

#Ora creiamo il vero e proprio dataframe mettendo insieme i 3 vettori
#uso la funzione data.frame()
tabout <- data.frame (class, p1992, p2006)
tabout #richiamandola visualizzo la tabella

#Ora facciamo un grafico grazie al pacchetto ggplot
#Partiamo dall'immagine del 1992
#nell'argomento della funzione ggplot specifico per primo argomento la tabella da plottare
#poi le aestetics, ovvero a cosa corrisponde la x (classi), 
#la y (valori percentuali del 1992) e il colore che voglio
#dopo che ho finito la funzione ggplot definisco che grafico voglio
#usando + e la nuova funzion geom_bar
#all'interno dell'argomento di geom_bar stat="identity" significa che 
#prendo il valore esatto che gli sto dando
#mentre fill="" ci permette di scegliere il colore che voglio usare
#1992
ggplot (tabout, aes(x=class, y=p1992, color=class))+ geom_bar(stat="identity", fill="white")
#2006
ggplot (tabout, aes(x=class, y=p2006, color=class))+ geom_bar(stat="identity", fill="white")

#Installiamo ora un nuovo pacchetto
#Il pacchetto patchwork ci permette di unire i due grafici
install.packages(patchwork)
library(patchwork) #lo richiamiamo per vedere se è avvenuta l'installazione

#Associo un oggetto ad entrambi i grafici creati prima
p1 <- ggplot (tabout, aes(x=class, y=p1992, color=class))+ geom_bar(stat="identity", fill="white")
p2 <- ggplot (tabout, aes(x=class, y=p2006, color=class))+ geom_bar(stat="identity", fill="white")
p1+p2 #sommando in questo modo i due grafici li metto uno affianco all'altro, ma la scala dei 2 è diversa
#se avessi voluto metterli uno sopra l'altro avrei fatto p1/p2

#Quindi cosa facciamo per metterli in scala?
#metto alla y un limite usando ylim
#in questo modo specifico che per ambedue i miei grafici la y deve andare da 0 a 100
#serve c() perché sono due valori, e uso il 100 perché si tratta di percentuali
p1 <- ggplot (tabout, aes(x=class, y=p1992, color=class))+ geom_bar(stat="identity", fill="white")+ ylim (c(0,100))
p2 <- ggplot (tabout, aes(x=class, y=p2006, color=class))+ geom_bar(stat="identity", fill="white")+ ylim (c(0,100))
p1+p2 #ora mettendo i 2 grafici vicini posso effettivamente valutare la perdita di foresta








