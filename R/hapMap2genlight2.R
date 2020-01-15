hapMap2genlight2 <- function(file){
  require(adegenet)
  hapmapraw1 <- read.csv(file.choose(), header=TRUE, row.names=1, sep="\t",
                         stringsAsFactors=FALSE,check.names = F)[,-(2:10)] # cowpea_hapmap.hmp.txt this is the clean file
  monolist=c("A","C","G","T")
  delelist=c("-/+"," +/-")
  hapmapraw2 <- hapmapraw1[!hapmapraw1$alleles%in%monolist, ]
  hapmap <- rbind(hapmapraw2[!hapmapraw2$alleles%in%delelist, ],hapmapraw2[hapmapraw2$alleles%in%delelist, ])
  delecount=table(hapmapraw2$alleles%in%delelist)["TRUE"] 
  
  samples <- names(hapmap)[-1]
  loci <- row.names(hapmap)
  
  # set up conversion table
  s <- as.integer(c(0,1,2,NA))
  ac <- s
  ag <- s
  at <- s
  cg <- s
  ct <- s
  gt <- s
  adele=s
  cdele=s
  gdele=s
  tdele=s
  dele=s
  names(ac) <- c("A","M","C","N")
  names(ag) <- c("A","R","G","N")
  names(at) <- c("A","W","T","N")
  names(cg) <- c("C","S","G","N")
  names(ct) <- c("C","Y","T","N")
  names(gt) <- c("G","K","T","N")
  names(adele) <- c("-","0","A","N")
  names(cdele) <- c("-","0","C","N")
  names(gdele) <- c("-","0","G","N")
  names(tdele) <- c("-","0","T","N")
  names(dele) <- c("-","0","Dummy","N")
  
  conv <- list(ac,ac,ag,ag,at,at,cg,cg,ct,ct,gt,gt,
               adele,adele,cdele,cdele,gdele,gdele,tdele,tdele,dele,dele)
  names(conv) <- c("A/C","C/A","A/G","G/A","A/T","T/A","C/G","G/C",
                   "C/T","T/C","G/T","T/G",
                   "A/-","-/A","C/-","-/C","G/-","-/G","T/-","-/T","-/+","+/-")
  
  # Pull out and convert genotypes
  S <- length(samples)
  SBlist <- vector(mode="list",S)   # set up list of SNPbin objects
  
  total <- S
  # create progress bar
  pb <- txtProgressBar(min = 1, max = S, style = 3)
  
  for(i in 1:S){
    mygen <- mapply(function(type,gen) unname(conv[[type]][gen]),
                    type=hapmap[[1]], gen=hapmap[[i+1]],
                    SIMPLIFY=T, USE.NAMES=FALSE)
    mygen[sapply(mygen , is.null)] <- NA
    # create SNPbin object for this individual
    SBlist[[i]] <- new("SNPbin", unlist(mygen))
    setTxtProgressBar(pb, i)
  }
  
  # make genlight object
  x <- new("genlight", SBlist,n.loc=length(loci),ind.names=samples,loc.names=loci)
  output=list(x,delecount)
  return(output)
}
