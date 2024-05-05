#Prima lezione di telerilevamento
#Impariamo ad usare R
#Per prima cosa associamo una funzione (molitplicazione) ad un oggetto (lettera)
a <- 6*7
b <- 5*8

(6*7)+(5*8) #il risultato è 82, ma possiamo esprimere quest'operazione anche in un altro modo
a+b #esprimiamo la stessa operazione di prima, quindi il risultato è sempre 82

#Arrays o vettori, sono serie di oggetti 
#attraverso la funzione concatenate creiamo un vettore 
#assegniamo sempre alla funzione un oggetto, flowers in questo caso

flowers <- c(3, 6, 8, 10, 15, 18) #se non avessi usato la fuznione c(), R avrebbe assegnato all'oggeto flowers solo il primo numero
flowers

insects <- c(10,  16, 25, 42, 61, 73)
insects

plot (flowers, insects)

#changing plot paramet

#color

plot (flowers, insects, col= "darkmagenta")

#symbols
plot (flowers, insects, col= "darkmagenta", pch= 24)

#symbol dimensions
plot (flowers, insects, col= "darkmagenta", pch= 24, cex= 2)


