# dpaudelR
Common R functions:

_dpaudelR_ consists of some simple functions for data wrangling in R.

### To install:

```
install.packages("devtools")
library(devtools)
install_github("dpaudel/dpaudelR") 
```

### To use:

```
library(dpaudelR)
```

### Example uses


_copy2clipboard_ : This function copies a data frame to excel

```
copy2clipboard(dataframe)
```

_diagnostics_ : Plot diagnostics in anova

```
diagnostics(aov1)
```

_theme_uf_ : GGplot2 theme for UF dissertation template

```
+ theme_uf()
```

_write.list_dev_ : Function to write output of a list 

```
write.list_dev(file="data.txt", data_list, col.names = F, row.names = T, quote = F)
```
