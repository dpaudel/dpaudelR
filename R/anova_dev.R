#' ANOVA dev
#'
#' This function produces ANOVA table, HSD table, and barplot then copies table to clipboard
#'
#' 
#' @return A clipboard
#' @export
# anova_dev(Petal.Length~Species, iris)
anova_dev <- function (user_model, user_data){
  model1a <- as.formula(user_model)
  user_treatment <- as.character(formula(user_model))[2]
  user_group <- as.character(formula(user_model))[3]
  aov1 <- aov(model1a, data=user_data)
  print("ANOVA table")
  print(summary(aov1))
  
  # Tukey HSD
  hsd_aov1 <- HSD.test(aov1, user_group, group=TRUE)
  
  # Sort
  order_aov1 <- hsd_aov1$groups[order(rownames(hsd_aov1$groups)),]
  
  # Add species column
  order_aov1 <- order_aov1 %>% mutate(Name=rownames(order_aov1))
  
  # Get summary statistics from Rmisc package
  data1a <- user_data
  data_stats <- summarySE(data1a, measurevar= user_treatment , groupvars= user_group, na.rm=TRUE)
  
  # Merge HSD grouping and summary statistics
  
  data_merged <- left_join(data_stats, order_aov1)
  print("HSD ranking")
  print(data_merged)
  # Print
  copy2clipboard(data_merged)
  print("Use Ctrl+V to paste summary means into Excel worksheet")
  
  # Create standard error bars
  yerr_names1 <- colnames(data_merged)[c(3,5)]
  yerrbar1 <- aes_string(ymin = paste(yerr_names1, collapse = '-'), 
                         ymax = paste(yerr_names1,collapse='+'))
  nudge_amt <- 0
  if (mean(data_merged$se) < 1){
    nudge_amt <- 5*mean(data_merged$se)
  } else {
    nudge_amt <- 2*mean(data_merged$se)}
  # Plot
  plot1 <- ggplot(data_merged, aes_string(x=user_group, y=user_treatment, fill=user_group))+
    geom_bar(position=position_dodge(.5), stat="identity", colour="black", width = 0.5)+
    geom_errorbar(mapping = yerrbar1, width=0.2)+
    geom_text(nudge_y=nudge_amt, label=data_merged$groups,  size=4) +
    ggtitle("HSD grouping")+
    theme_uf() # from dpaudelR package
  print(plot1)
}
