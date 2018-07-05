source("setup.R")

jj <- myopt(schedule_start,maxit=100000)
## NB: could use 'myopt(optimal_schedule)' for a hot-start


new_optimal_schedule <- jj$par
save(new_optimal_schedule, file="new_optimal_schedule.RData")
