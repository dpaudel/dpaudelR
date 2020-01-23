#### function to plot histograms of different data transformations ####
# dataframe, column_name
# dataframe=pheno_292
# column_name='Days_to_pod_maturity'
# data_transform(dataframe, 'column_name')
# data_transform(phenotype,'Days_to_pod_maturity')
data_transform <- function(dataframe, column_name){
  newd <- data.frame(dataframe %>% select(column_name))
  newd$log <- log(newd[,1])
  newd$log10 <- log10(newd[,1])
  newd$sqrt <- sqrt(newd[,1])
  if(max(newd[,1]) <=1 & min(newd[,1]>=0)){
  newd$asin_sqrt <- asin(sqrt(newd[,1]))
  }
  num_cols <- dim(newd)[2]
  newd %>% 
    tidyr::gather(variable, value) %>% 
    ggplot(aes(value)) + 
    # it sets bins intead of breaks, so add 1
    geom_histogram(bins =(nrow(newd)/10) %>% round(., digits=0), color='black', fill='grey40') + 
    # make a new "facet" for each value of `variable` (formerly column names), and 
    # use a convenient x-scale instead of the same for all 3
    facet_wrap(~variable, scales = 'free_x')+
    theme_bw()
}

