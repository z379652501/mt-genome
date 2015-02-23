# RStudio is recommended
# heatmap.R
# Yi-Jyun Luo | 2014.03.15

library(plots)
library(ggplot2)
library(pheatmap)
library(RColorBrewer)
data <- read.table("~/CREX_analysis_protein_coding.txt", header=TRUE)
matrix <- data.matrix(data)
my_palette <- colorRampPalette(c("red", "blue", "white"))(n = 32)
pheatmap(matrix, cluster_cols=FALSE, cluster_rows=FALSE, col=my_palette, scale="none", key=TRUE, symkey=FALSE, density.info="none", trace="none", cexCol=1, cexRow=1, cellwidth=10, cellheight=10)
