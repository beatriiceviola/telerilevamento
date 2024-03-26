#Spectral indices
library(terra)
library(imageRy)

#list of files
im.list()

im.import("matogrosso_l5_1992219_lrg.jpg")
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

#bands
# banda 1 = NIR
# banda 2 = red
# banda 3 = green

#plot RGB
#NIR on red (la vegetazione appare rossa)
im.plotRGB(m1992, r=1, g=2, b=3)

#NIR on green (la vegetazione appare verde)
im.plotRGB(m1992,r=2, g=1, b=3)

#NIR on blue (la vegetazione appare blu)
im.plotRGB(m1992, r=2, g=3, b=1)

#2006
im.import("matogrosso_ast_2006209_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

#mettimao l eimmagini vicine
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

dev.off()

#NIR ontop of green
im.plotRGB(m2006, r=2, g=1, b=3)

#NIR ontop of blue
im.plotRGB(m2006, r=2, g=3, b=1)

#mettiamo tutte e 6 le immagini insieme
par(mfrow=c(2,3))
im.plotRGB(m1992, r=1, g=2, b=3) #1992 on red
im.plotRGB(m1992,r=2, g=1, b=3) #1992 on green
im.plotRGB(m1992, r=2, g=3, b=1) #1992 on blue
im.plotRGB(m2006, r=1, g=2, b=3) #2006 on red
im.plotRGB(m2006, r=2, g=1, b=3) #2006 on green
im.plotRGB(m2006, r=2, g=3, b=1) #2006 on blue




