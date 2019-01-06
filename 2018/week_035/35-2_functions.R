library(tidyverse)

fix_county <- function(x){
  if(x == "Baltimore city") {
    x <- "Baltimore City"
  }
  return(x)
}
