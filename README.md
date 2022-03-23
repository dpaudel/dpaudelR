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

_anova_hsd_ : This function performs single-factor ANOVA and outputs Tukey's HSD test as well as a barplot.

```
anova_hsd(user_model, dataset)
anova_hsd(Petal.Length~Species, iris)
```

_anova_lsd_ : This function performs single-factor ANOVA and outputs LSD test as well as a barplot.

```
anova_lsd(user_model, dataset)
anova_lsd(Petal.Length~Species, iris)
```


_copy2clipboard_ : This function copies a data frame to excel

```
copy2clipboard(dataframe)
# If the data is a list then follow this:
bind_rows(list) %>% copy2clipboard()
bind_rows(summary(model_nlm1)) %>% copy2clipboard()
```

_copyFromExcel_ : This function copies data from Excel to R

```
# Ctrl + C a dataframe in Excel
data <- copyFromExcel()
```

_data_transform_ : Transform data and plot histogram for log, log10, square root, and arcsine transformation

```
# data_transform(dataframe, 'column_name', numberOfBins)
data_transform(phenotype, 'Days_to_flower', 30)
```
_diagnostics_ : Plot diagnostics in anova

```
diagnostics(residuals, fittedvalues)
```

_dp_circlize_blast_ : Create a circos plot from blast output tablular format

```
test_blast1 <- read.table("blast_output_tabular_format.txt")
dp_circlize_blast(test_blast1)
```

_hapMap2genlight2.R_ : Convert TASSEL hapmap file to _genlight_ object for adegenet

```
mygeno=hapMap2genlight2(file.choose()) # choose hapmap file (remove # from rs# and assembly# on column names first)
mygeno1 <- mygeno[[1]] # genlight object for DAPC
```

_pin_ : Function to correct Standard Error of heritability estimates in ASREML (ASREML produces SE > 2)

```
pin(modelN, H2~V1/(V1+V2))
```

_plot_gwas_snp_ : Function to give allele summary and plot in GAPIT

```
# plot_gwas_snp(genotype_data,phenotype_data,'snp_name','phenotype_name')
# myGDh <- read.table('hapmap_clean2.hmp.txt', head=FALSE) 
plot_gwas_snp(myGDh,pheno_292,'2_25641','Days_to_flower')

```

_singlify_header_ : Function to create a single header from multiple header rows

```
# singlify_header("filename", number of rows to skip, number of rows with headers)
singlify_header('Griffin_20200204/SCRI II Bermudagrass SSPN Griffin Final.xlsx', nskip=2,nheaders=4)
```

_theme_uf_ : GGplot2 theme for _University of Florida_ dissertation template

```
+ theme_uf()
```

_write.list_dev_ : Function to write output of a list 

```
write.list_dev(file="data.txt", data_list, col.names = F, row.names = T, quote = F)
```

