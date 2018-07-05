source("setup.R")

jj <- myopt(schedule_start,maxit=100000)
## NB: could use 'myopt(optimal_schedule)' for a hot-start

optimal_schedule <- jj$par
save(optimal_schedule, file="optimal_schedule.RData")
