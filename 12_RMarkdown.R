#

---
title: "Vignette"
author: "Beatrice Viola"
date: "2024-05-16"
output: html_document
---

#My first Markdown file!
This file contains functions for R scripting in Geo-Ecological Remote Sensing.

We are going to make use of the following packages:

```{r}
library(imageRy)
library(terra)
library(viridis)
```

In order to visualize the list of data use:
```{r, eval=TRUE} 
im.list()
```

In order to import data we can use the following function:
```{r, eval=T} 
mato <- im.import("matogrosso_ast_2006209_lrg.jpg")
```
This plot is related to the following bands: band 1 = NIR, band 2 = red, band 3 = green

We can change the visualitazion by changing the order of bands in RGB space as:
```{r} 
im.plotRGB(mato, 2, 1, 3)
```

In order to look at different band combination all together we can use:
```{r} 
par(mfrow=c(1,3))
im.plotRGB(mato, 1,2,3)
im.plotRGB(mato, 2,1,3)
im.plotRGB(mato, 3,2,1)
```

## Calculating spectral indices
```{r, eval=T} 
dvi <- mato[[1]]-mato[[2]]
plot(dvi)
```

## Calculating spatial variability
```{r, eval=t} 
sd5 <- focal(mato[[1]], matrix(1/25, 5, 5), fun=sd)
plot(sd5, col=magma(100))
```
