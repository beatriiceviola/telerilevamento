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

insects <- c(10,  16, 25, 42, 61, 73) #altro esempio con la funzione concatenate
insects

#Ora posso fare un plot(x,y)
plot (flowers, insects)

#la funzione plot possiede vari parametri tra cui
#il colore, posso modificarlo scrivendo all'interno del plot
#plot(x, y, col=""), all'interno delle virgolette inserisco il nome del colore
#che desidero tra quelli presenti in R

plot (flowers, insects, col= "darkmagenta")

#poi posso cambiare i simboli usando pch=""
#tra le virgolette inserisco un numero che corrisponde a un simbolo
#(per capire che numero usare in base alsimbolo che voglio uso tabelle specifiche)
plot (flowers, insects, col= "darkmagenta", pch= 24)

#ancora posso cambiare la dimensione dei simboli
#con cex="", tra virgolette indico di quanto voglio aumentare o diminuire il simbolo
plot (flowers, insects, col= "darkmagenta", pch= 24, cex= 2)

#infine posso modificare il nome delle mie ascisse e ordinate
#faccio ciò aggiungendo xlab="" e ylab="" 
#sempre specificando tra virgolette il nome che voglio usare
plot (xlab="carbonati", ylab="anidride carbonica", col= "darkmagenta", pch= 24, cex= 2)
