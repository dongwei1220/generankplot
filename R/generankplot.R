#' @title Gene Ranking DotPlot
#'
#' @description This package is used to draw gene rangking dot plot.
#'
#' @author Wei Dong <dongw26@mail2.sysu.edu.cn>
#'
#' @param data a dataframe with three columns: gene, log2FC and pvalue.
#' @param top_n set the number of top gene for labeling, default = 10.
#' @param palette set the dot plot color palette.
#' @param log2fc set the threshold of log2foldchage, default = 1.
#' @param label_size set the font size of labels, default = 5.
#' @param x_lab set the x-axis label.
#' @param y_lab set the y-axis label.
#'
#' @return a ggplot2 object of gene ranking dotplot.
#' @export
#' @import ggplot2
#' @import ggrepel
#' @import RColorBrewer
#' @importFrom("grDevices", "colorRampPalette")
#' @importFrom("stats", "median")
#' @importFrom("utils", "head", "tail")
#'
#' @examples
#' require(viridis)
#' data(diff_express)
#' head(diff_express)
#' generankplot(diff_express,top_n = 5)
#' generankplot(diff_express,top_n = 10,palette = "RdBu")
#' p <- generankplot(diff_express,top_n = 10,log2fc = 1.5)
#' p + scale_color_viridis()
generankplot <- function(data, top_n = 10, palette = "Spectral",
                         log2fc = 1, label_size = 5,
                         x_lab = "Rank of differentially expressed genes",
                         y_lab = "Log2FoldChange")
{
  # check required packages
  if (!requireNamespace("ggplot2")) {
    stop("Please install ggplot2 first.", call. = FALSE)
  }
  if (!requireNamespace("ggrepel")) {
    stop("Please install ggrepel first.", call. = FALSE)
  }
  if (!requireNamespace("RColorBrewer")) {
    stop("Please install RColorBrewer first.", call. = FALSE)
  }

  # check data columns
  if (ncol(data) == 3) {
    # nothing
  } else {
    print("Error: Input data should be 3 columns: gene, log2FC, pvalue!")
  }
  # rename data colnames
  colnames(data) <- c("gene", "log2FC", "pvalue")

  # ordered by log2FoldChange and pvalue
  data <- data[order(-data$log2FC, data$pvalue), ]
  # add the ranking column
  data$rank <- 1:nrow(data)
  # head(data)

  # get the top n up and down gene for labeling
  top_n_up <- head(rownames(data),top_n)
  top_n_down <- tail(rownames(data), top_n)
  genes_to_label <- c(top_n_up, top_n_down)

  # set the color palettes
  colors <- brewer.pal(8, palette)

  # make the gene ranking dotplot
  p <- ggplot(data, aes(x = rank, y = log2FC,
                        color = pvalue, size = abs(log2FC))) +
       geom_point() +
       scale_color_gradientn(colours = colorRampPalette(colors)(1000)) +
       geom_hline(yintercept = c(-log2fc, log2fc), linetype = 2, size = 0.3) +
       geom_hline(yintercept = 0, linetype = 1, size = 0.5) +
       geom_vline(xintercept = median(data$rank), linetype = 2, size = 0.3) +
       geom_text_repel(data = data[genes_to_label,], max.overlaps = 20,
                       aes(x = rank, y = log2FC, label = gene),
                       size = label_size, color = "red") +
       xlab(x_lab) + ylab(y_lab) +
       ylim(c(-max(abs(data$log2FC)), max(abs(data$log2FC)))) +
       labs(color = "Pvalue", size = "Log2FoldChange") +
       theme_bw(base_size = 12)
  return(p)
}
