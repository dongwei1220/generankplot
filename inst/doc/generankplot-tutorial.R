## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- fig.width=7,fig.height=5------------------------------------------------
library(generankplot)

## basic example code
require(viridis)
data(diff_express)
head(diff_express)

generankplot(diff_express,top_n = 5)
generankplot(diff_express,top_n = 10,palette = "RdBu")
p <- generankplot(diff_express,top_n = 10,log2fc = 1.5)
p + scale_color_viridis()

