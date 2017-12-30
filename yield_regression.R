library(panelNNET)
library(tidyverse)

# Load cropdat

cropdat <- readRDS("data/full_ag_data.rds")
regdat <- filter(cropdat, year <= 2008 )
tdat <- filter(cropdat, year == 2000)
tdat <- select(tdat,dday0_10, dday10_30, dday30, prec, prec_sq)

mod <- panelNNET.default(y = regdat$corn_yield, 
                         X = data.frame(regdat$dday0_10, regdat$dday10_30, regdat$dday30, regdat$prec, regdat$prec_sq),
                         hidden_units = 1, 
                         fe_var = regdat$fips, 
                         time_var = regdat$year,
                         param = data.frame(regdat$dday0_10, regdat$dday10_30, regdat$dday30, regdat$prec, regdat$prec_sq ))

old.pdat <- predict(mod)
head(old.pdat)

pdat <- predict(mod, tdat, new.param = tdat)

