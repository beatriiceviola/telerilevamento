# First R script

# R as calculator
a <-6 * 7
b <- 5*8

a+b

#Arrays

flowers <- c(3, 6, 8, 10, 15, 18)
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


