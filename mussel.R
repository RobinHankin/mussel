library(magrittr)
library(TSP)

source("farm_setup.R")
source("example_schedule.R")
source("schedule_funcs.R")
source("cost_functions.R")
source("gradfuncs.R")   # define gradfunc()

attach(params)
out <-
optim(schedule,
      fn=objective,
      gr=gradfunc,
      method="SANN",
      control=list(maxit=10000,trace=100)
      )
detach(params)
