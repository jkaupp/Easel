library(tidyverse)
library(googlesheets)

framework <- gs_title("(17-05-05)Data-Needs_Shared.xlsx") %>%
  gs_read(ws = 2)

feather::write_feather(framework, "easel/framework.feather")

