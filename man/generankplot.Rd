% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generankplot.R
\name{generankplot}
\alias{generankplot}
\title{Gene Ranking DotPlot}
\usage{
generankplot(
  data,
  top_n = 10,
  palette = "Spectral",
  log2fc = 1,
  label_size = 6,
  x_lab = "Rank of differentially expressed genes",
  y_lab = "Log2FoldChange"
)
}
\arguments{
\item{data}{a dataframe with three columns: gene, log2FC and pvalue.}

\item{top_n}{set the number of top gene for labeling, default = 10.}

\item{palette}{set the dot plot color palette.}

\item{log2fc}{set the threshold of log2foldchage, default = 1.}

\item{label_size}{set the font size of labels, default = 10.}

\item{x_lab}{set the x-axis label.}

\item{y_lab}{set the y-axis label.}
}
\value{
a ggplot2 object of gene ranking dotplot.
}
\description{
This package is used to draw gene rangking dot plot.
}
\examples{
require(viridis)
data(diff_express)
head(diff_express)
generankplot(diff_express,top_n = 5)
generankplot(diff_express,top_n = 10,palette = "RdBu")
p <- generankplot(diff_express,top_n = 10,log2fc = 1.5)
p + scale_color_viridis()
}
\author{
Wei Dong <dongw26@mail2.sysu.edu.cn>
}
