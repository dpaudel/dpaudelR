#' Circlize blast results
#'
#' This function produces circos plots from blast result tabular format
#'
#' 
#' @return A circosplot
#' @export
# dp_circlize_blast(blast_output)
dp_circlize_blast<- function(testblast1){
  blast_header <- c("queryId", "subjectId", "percIdentity", "alnLength", "mismatchCount", "gapOpenCount", "queryStart", "queryEnd", "subjectStart", "subjectEnd", "eVal", "bitScore")
  colnames(test_blast1)<- blast_header
  length_query <- test_blast1 %>% group_by(queryId) %>% summarise(chrlength=max(queryEnd)) %>% rename(chr=queryId) %>% mutate(type="query")
  length_subject <- test_blast1 %>% group_by(subjectId) %>% summarise(chrlength=max(subjectEnd))%>% rename(chr=subjectId) %>% mutate(type="subject")
  
  allchr_length <- rbind(length_query, length_subject)
  bed2 <- test_blast1 %>% select(queryId, queryStart, queryEnd) %>% rename(chr=queryId, start=queryStart, end=queryEnd) %>% mutate(color1=as.numeric(as.factor(chr))) 
  bed1 <- test_blast1 %>% select(subjectId, subjectStart, subjectEnd) %>% rename(chr=subjectId, start=subjectStart, end=subjectEnd) %>% mutate(color1=as.numeric(as.factor(chr))) 
  circosname=paste0("circos_",format(Sys.time(), "%Y-%b-%d-%H.%M.%S"), ".png")
  png(filename=circosname, width=7, height=7, units="in", res=1200)
  circos.clear()
  circos.par(cell.padding = c(0.02, 0, 0.02, 0))
  circos.initialize(factors=unique(allchr_length$chr),xlim=matrix(c(rep(0,length(unique(allchr_length$chr))), allchr_length$chrlength), ncol=2))
  # genomes
  col_text <- "grey40"
  circos.track(ylim=c(0,1),panel.fun=function(x,y) {
    chr=CELL_META$sector.index
    xlim=CELL_META$xlim
    ylim=CELL_META$ylim
    circos.text(mean(xlim),mean(ylim),chr, cex=0.5,col=col_text,facing="bending.inside",niceFacing=TRUE)
    facing = c("inside", "outside", "reverse.clockwise", "clockwise", "downward", "bending.inside","bending.outside")
  },
  bg.col=(as.numeric(as.factor(allchr_length$type))+2),bg.border=F,track.height=0.06)
  #bg.col="grey90",bg.border=F,track.height=0.06)
  
  circos.genomicLink(bed1, bed2, col = add_transparency(bed2$color1, 0.8), border = NA)
  dev.off()
  print(circosname)
  return(getwd())
}
