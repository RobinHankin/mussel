library("magrittr")
library("TSP")

source("farm_setup.R")

attach(params)

source("example_schedule.R")
source("schedule_funcs.R")
source("cost_functions.R")
source("gradfuncs.R")   # define gradfunc()

out <-
optim(schedule,
      fn=objective,
      gr=gradfunc,
      method="SANN",
      control=list(maxit=100000,trace=TRUE,fnscale= -1e6) # maximizing; fnscale<0
      )

out$itinerary <- apply(out$par,2,get_itinerary_one_block)
detach(params)
