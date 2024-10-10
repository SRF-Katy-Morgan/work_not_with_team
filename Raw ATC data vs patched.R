
library(tidyverse)

patched <- readxl::read_xlsx('Patched data minor ATCs in London.xlsx')
raw <- readxl::read_xlsx('Raw data minor ATCs in London.xlsx')


ATC_304_patched <- patched %>% filter(ATC_Site == '304')
ATC_304_raw <- raw %>% filter(ATC_Site == '304')

ggplot(ATC_304_patched)