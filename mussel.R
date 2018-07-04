source("setup.R")

jj <- myopt(schedule_start)

optimal_schedule <- jj$par
save(optimal_schedule, file="optimal_schedule.RData")
