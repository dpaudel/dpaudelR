#` Data transform
#'
#' This function transforms data and plots histogram
#' 
#' @export
#' dataframe, column_name
#' data_transform(dataframe, 'column_name', numberOfBins)
#' data_transform(phenotype,'Days_to_pod_maturity', 30)
data_transform <- function(dataframe, column_name, numbins){
  newd <- data.frame(dataframe %>% dplyr::select(column_name) %>%drop_na())
  newd$log <- log(newd[,1])
  newd$log10 <- log10(newd[,1])
  newd$sqrt <- sqrt(newd[,1])
  if(max(newd[,1]) <=1 & min(newd[,1]>=0)){
  newd$asin_sqrt <- asin(sqrt(newd[,1]))
  }
  if(max(newd[,1]) <=100 & min(newd[,1]>=0)){ # convert to proportion for arcsine transformation
    newd$asin_sqrt <- asin(sqrt((newd[,1]/100)))
  }
  newd %>% 
    tidyr::gather(variable, value) %>% 
    ggplot(aes(value)) + 
    # it sets bins intead of breaks, so add 1
    geom_histogram(bins = numbins, color='black', fill='grey40') + 
    # make a new "facet" for each value of `variable` (formerly column names), and 
    # use a convenient x-scale instead of the same for all 
    facet_wrap(~variable, scales = 'free_x')+
    theme_bw()
}
