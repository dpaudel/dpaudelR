# dpaudelR
[Dev Paudel](https://dpaudel.github.io/)'s commonly used R functions:

_dpaudelR_ consists of some simple functions for data wrangling in R.

### To install:

```
devtools::install_github("dpaudel/dpaudelR") 
# OR
install.packages("devtools")
library(devtools)
install_github("dpaudel/dpaudelR") 
```

### To use:

```
library(dpaudelR)
```

### Example uses

_anova_dev_ : This function performs single-factor ANOVA and outputs Tukey's HSD test as well as a barplot.

```
anova_dev(user_model, dataset)
anova_dev(Petal.Length~Species, iris)
```

_copy2clipboard_ : This function copies a data frame to excel

```
copy2clipboard(dataframe)
```

_copyFromExcel_ : This function copies data from Excel to R

```
# Ctrl + C a dataframe in Excel
data <- copyFromExcel()
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

_pin_ : Function to correct Standard Error of heritability estimates in ASREML (ASREML produces SE > 2)

```
pin(modelN, H2~V1/(V1+V2))
```
