#' Plot blast output
#'
#' This function produces blast graphic output from tabular blast data
#'
#' 
#' @return A ggplot
#' @export
# plot_blast_segment(blast_data)
# plot_blast_segment(read.table("blast_output_tabular.txt"))

plot_blast_segment <- function(blast_data){
  blast_header <- c("queryId", "subjectId", "percIdentity", "alnLength", "mismatchCount", "gapOpenCount", "queryStart", "queryEnd", "subjectStart", "subjectEnd", "eVal", "bitScore")
  colnames(blast_data)<-blast_header
  blast_data$queryId <- as.factor(blast_data$queryId)
  blast_data$subjectId <- as.factor(blast_data$subjectId)
  #if (dir.exists("plots")) {} else {dir.create("plots")}
  #imgname=paste0("plots/plot_",filename,".png")
  (plot_blast <- blast_data %>% ggplot()+
      geom_segment(aes(x=subjectStart, y=queryId, xend=subjectEnd,yend=queryId, col=percIdentity), size=2)+
      theme_bw()+
      xlab(unique(blast_data$subjectId))+
      ggthemes::scale_color_gradient2_tableau())
  #ggsave(imgname, width=7, height=5, units="in", dpi=300)
  return(plot_blast)
}
