#Installing new packages in R
install.packages("terra")

#per vedere se il pacchetto è stato installato inseriamo
library(terra)

#install new packages devtools in CRAN
install.packages("devtools")

#poi controlliamo se devtools è stato installato con
library(devtools)

# install the imageRy package from GitHub
#a devtools function
devtools::install_github("ducciorocchini/imageRy")


#controlliamo l'installazione sempre con library
library(imageRy)
