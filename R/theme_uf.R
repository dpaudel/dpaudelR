theme_uf <- function () {
library(extrafont)
loadfonts(device = "win")
windowsFonts(Arial=windowsFont("TT Arial"))
    theme_bw(base_size=12, base_family="Arial") %+replace% 
      theme(
        panel.background  = element_blank(),
        plot.background = element_rect(fill="white", colour=NA), 
        legend.background = element_rect(fill="transparent", colour=NA),
        legend.key        = element_rect(fill="transparent", colour=NA)
      )
  }
