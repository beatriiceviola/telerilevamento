#Second method to quantify changes in time
#The first method was based on classification

library(terra)
library(imageRy)

im.list()

#import the data
EN01<- im.import("EN_01.png")
EN13<- im.import("EN_13.png")


par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)


difEN = EN01[[1]]-EN13[[1]]
cl<- colorRampPalette(c("red", "white", "blue"))(100)
plot(difEN, col=cl)













