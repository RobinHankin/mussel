library("magrittr")
library("TSP")

if("params" %in% search()){detach(params)}
source("setup.R")
attach(params)

source("schedule_funcs.R")
source("cost_functions.R")

out <-
  optim(
      schedule,
      fn=objective,
      gr=gradfunc,
      method="SANN",
      control=list(maxit=100000,trace=TRUE,fnscale= -1e6) # maximizing; fnscale<0
  )

out$itinerary <- apply(out$par,2,get_itinerary_one_block)
