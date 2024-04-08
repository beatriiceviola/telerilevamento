#quantifying land cover change
install.packages("ggplot2")

library(terra)
library(imageRy)
library(ggplot2)

im.list()

#importing images
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#classifying images
im.classify(sun, num_clusters=3)

#Importing matogrosso images
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") 
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

#classifying matogrosso images, 2 cluster
m1992c <- im.classify(m1992, num_clusters=2)

#1992
#class 1 = human
#class 2 = forest

#classyfing matogrosso images
m2006c <- im.classify (m2006, num_clusters=2)

#2006
# class 1 = forest
# class 2 = human

#frequencies 1992 
f1992 <- freq(m1992c)
f1992

# proportions
tot1992 <- ncell(m1992c)
tot1992
#tot= 1800000

prop1992 = f1992/tot1992
prop1992
#

#percentages
perc1992 = prop1992 * 100
perc1992

#17% human, 83% forest

#frequencies 2006
f2006 <- freq(m2006c)
f2006

# proportions
tot2006 <- ncell(m2006c)
tot2006
#tot= 7200000

prop2006 = f2006/tot2006
prop2006

#percentages
perc2006 = prop2006 * 100
perc2006

#55% human, 45% forest

#let's build a dataframe
class <- c("forest", "human")
p1992 <- c(83, 17)
p2006 <- c(45, 55)

tabout <- data.frame (class, p1992, p2006)
tabout

#plotting the output
#nel grafico le x sono le classi e la y sono le percentuali
#dopo che ho finito la funzione ggplot definisco che grafico voglio, usando + e la nuova funzion geom_bar
#1992
ggplot (tabout, aes(x=class, y=p1992, color=class))+ geom_bar(stat="identity", fill="white")
#2006
ggplot (tabout, aes(x=class, y=p2006, color=class))+ geom_bar(stat="identity", fill="white")


#install.packages(patchwork)

library(patchwork)

#patchwork
p1 <- ggplot (tabout, aes(x=class, y=p1992, color=class))+ geom_bar(stat="identity", fill="white")
p2 <- ggplot (tabout, aes(x=class, y=p2006, color=class))+ geom_bar(stat="identity", fill="white")
p1+p2

#i due grafici però non sono in scala, quindi per metterli in scala facciamo
p1 <- ggplot (tabout, aes(x=class, y=p1992, color=class))+ geom_bar(stat="identity", fill="white")+ ylim (c(0,100))
p2 <- ggplot (tabout, aes(x=class, y=p2006, color=class))+ geom_bar(stat="identity", fill="white")+ ylim (c(0,100))
p1+p2








