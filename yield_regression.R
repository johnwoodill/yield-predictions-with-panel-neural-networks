library(panelNNET)
library(tidyverse)

# Load cropdat

cropdat <- readRDS("data/full_ag_data.rds")
regdat <- filter(cropdat, year <= 2008 )
tdat <- filter(cropdat, year == 2000)
tdat <- select(tdat,dday0_10, dday10_30, dday30, prec, prec_sq)

mod <- panelNNET.default(y = regdat$corn_yield, 
                         X = data.frame(regdat$dday0_10, regdat$dday10_30, regdat$dday30, regdat$prec, regdat$prec_sq),
                         fe_var = regdat$state,
                         hidden_units = 1, 
                         param = data.frame(regdat$dday0_10, regdat$dday10_30, regdat$dday30, regdat$prec, regdat$prec_sq ))

old.pdat <- predict(mod)
head(old.pdat)

pdat <- predict(mod, 
                newX = data.frame(tdat$dday0_10, tdat$dday10_30, tdat$dday30, tdat$prec, tdat$prec_sq), 
                new.param = data.frame(tdat$dday0_10, tdat$dday10_30, tdat$dday30, tdat$prec, tdat$prec_sq))

