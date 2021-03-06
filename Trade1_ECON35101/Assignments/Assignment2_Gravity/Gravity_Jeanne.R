## Problem Set 2 - Gravite - Jeanne

# Set pwd()
rm(list=ls())
require(readstata13)
require(fixest)
require(stargazer)
library(dplyr)

data = read.dta13("col_regfile09.dta")
data <- data %>% dplyr::select(flow, distw, iso_o, year, iso_d, contig, comlang_off)
data$lflow <- ifelse(data$flow > 0, log(data$flow), NA)
data$ldistw <- ifelse(data$distw > 0, log(data$distw), NA)

data$iso_d_year = as.factor(paste(data$iso_d, data$year, sep="_"))
data$iso_o_year = as.factor(paste(data$iso_o, data$year, sep="_"))

data = data %>% dplyr::filter(year >= 1948)
data = data %>% dplyr::filter(flow > 0)

start_time <- Sys.time()
model = feols(lflow ~ contig + comlang_off + ldistw | iso_o_year + iso_d_year, data)
end_time <- Sys.time()
time = end_time - start_time

etable(model, se = "white",
       notes=c(paste("Time is :", time, sep=" ")),
       tex = TRUE, file="Table3_R.tex", replace=T)


