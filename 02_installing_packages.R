#Installiamo nuovi pacchetti su R
#il primo pacchetto che installiamo è "terra"
#si tratta di un pacchetto situato su CRAN e quindi esterno ad R
#per i pacchetti dal CRAN usiamo la funzione install.packages("")
#terra è un pacchetto che serve per le analisi spaziali
install.packages("terra") 

#per vedere se il pacchetto è stato installato inseriamo
library(terra)

#installiamo ora il pacchetto devtools sempre da CRAN
#questo pacchetto ci serve per creare un collegamento con Github
install.packages("devtools")

#poi controlliamo se devtools è stato installato con
library(devtools)

# Per installare un pacchetto presente su Github
#mi serve una funzione presente sul pacchetto devtools che abbiamo installato prima
#questa funzione è install_github(""), tra virgolette metto lo user 
#da cui prendo il pacchetto/il nome del pacchetto
install_github("ducciorocchini/imageRy")

#Per far poi vedere a chi legge il mio codice da dove ho preso il pacchetto
#posso scrivere così
devtools:: install_github("ducciorocchini/imageRy")

#controlliamo l'installazione sempre con library
library(imageRy)
#R è un software case sensitive quindi in imageRy, ad esempio
#devo sempre mettere la R maiuscola

#Quando chiudo R devo richiamare i pacchetti che mi servono 
#ogni volta con library(),  solo che essendo pacchetti che ho già installato
#e che quindi sono presenti su R, non ho bisogno di mettere le virgolette
