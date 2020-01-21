#' Plot SNP
#'
#' For a given SNP name, this function gives summary and boxplot of the phenotype from hapmap file
#' 
#' @return A ggplot
#'
#' @export
#' plot_gwas_snp(genotype_data,phenotype_data,'snp_name','phenotype_name')
#' plot_gwas_snp(myGDh_292,pheno_only90,'2_37496','DWH1_2018')
#' myGDh101 = myGDh_292; pheno101 = pheno_only90; snp_name='2_37496'; phenotype_name='DWH1_2018'


plot_gwas_snp <- function(myGDh101,pheno101,snp_name,phenotype_name){
    names_101 <- myGDh101[1,] %>% unlist() %>% as.vector()
  myGDh_101_df <- myGDh101[-1,]
  colnames(myGDh_101_df)<- names_101
  names_selected <- c((myGDh101[1,1:11] %>% unlist() %>% as.vector()), (pheno101$taxa %>% as.vector)) %>% as.vector()
  myGDh101 <- myGDh_101_df %>% select(names_selected) 
    # Summary of the SNP allele
  list1 <- (myGDh101 %>% filter(rs==snp_name) %>% as.data.frame() %>% select(-c(1:11)) %>% t() %>% summary())
  # Extract alleles
  allele101 <- myGDh101 %>% filter(rs==snp_name) %>% as.data.frame() %>% select(-c(1:11)) %>% t() %>% as.data.frame()
  allele101$taxa <- row.names(allele101)
  colnames(allele101) <- c('Allele','taxa')
  allele_pheno101 <- inner_join(pheno101,allele101)
  selected101 <- as.data.frame(allele_pheno101 %>% select(taxa, Allele, phenotype_name))
  #boxplot(selected101[,3]~selected101[,2])
  colnames(selected101)<- c('taxa','Allele','Phenotype')
  list2 <- (aggregate(selected101[,3], by=list(selected101[,2]), FUN=mean))
  print('Count of alleles')
  print(list1)
  print('Mean of phenotype')
  print(list2)
  selected101 %>% ggplot(aes(x=Allele, y=Phenotype))+geom_boxplot()+geom_jitter(width=0.2)+theme_bw()+ylab(label=phenotype_name)
}
