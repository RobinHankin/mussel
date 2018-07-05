library("magrittr")
library("TSP")

if("params" %in% search()){detach(params)}



## scheduling problem for mussel collection
## First define harvest size:

yield <- c(f8463=142, f8468=162 ,f8487=40 ,f8391=39, f8378=32, f8344=162, f8337=23)  
farmnames <- names(yield)
jjharvest <- kronecker(t(rep(1,9)),yield)

rownames(jjharvest) <- farmnames
colnames(jjharvest) <- paste("block", seq_len(ncol(jjharvest)), sep="")

 ## set up inter-farm distances:

jjfarmdist <- as.matrix(read.table("farm_dist_matrix.txt"),header=FALSE)

## farmdist is a matrix of distances (symmetric)

params <- list(
    recovery       = 2,    # minimum number of nonharvesting blocks between two harvests
    boat_speed     = 25,   # speed of boat in km/h
    costperhour    = 400,  # cost of running boat, dollars
    maxhours       = 18,   # maximum hours in a working day
    costofoverrun  = 1e6,  # dollar cost of over-running workig day
    tons_per_hour  = 15,   # tons harvested per hour
    capacity       = 320,  # capacity of boat in tons
    commodity_price= 2500, # price of mussel harvest, dollars per ton

    no_of_farms = nrow(jjharvest),
    no_of_blocks = ncol(jjharvest),
    farmdist = jjfarmdist,  # element [i,j] is distance from farm i to farm j, km
    harvest  = jjharvest    # element [i,j] is harvest from farm i in week j, tons
    
    )




                                        # new params, big ==big problem:


jjbigharvest <- kronecker(params$harvest,matrix(1,5,6))[1:20,1:50]
jjbigharvest[3:10,30:40] <- 200
rownames(jjbigharvest) <- paste("farm",1001:1020,sep="")
colnames(jjbigharvest) <- paste("block",31:80,sep="")


jjbigfarmdist <-  kronecker(jjfarmdist,matrix(1,4,4))[1:20,1:20]+10

# add the base:
jjbigfarmdist <- cbind(jjbigfarmdist,20)
jjbigfarmdist <- rbind(jjbigfarmdist,20)
diag(jjbigfarmdist) <- 0

rownames(jjbigfarmdist) <- c(rownames(jjbigharvest),"base")
colnames(jjbigfarmdist) <- c(rownames(jjbigharvest),"base")


schedule_start <- jjbigharvest*0  # zero farms visited; idiom gets
                                  # rownames and colnames right

load("optimal_schedule.RData")  # pre-optimized schedule



params <- list(
    recovery       = 2,    # minimum number of nonharvesting blocks between two harvests
    boat_speed     = 25,   # speed of boat in km/h
    costperhour    = 400,  # cost of running boat, dollars
    maxhours       = 18,   # maximum hours in a working day
    costofoverrun  = 1e6,  # dollar cost of over-running workig day
    tons_per_hour  = 15,   # tons harvested per hour
    capacity       = 320,  # capacity of boat in tons
    commodity_price= 2500, # price of mussel harvest, dollars per ton

    no_of_farms = nrow(jjbigharvest),
    no_of_blocks = ncol(jjbigharvest),
    farmdist = jjbigfarmdist,  # element [i,j] is distance from farm i to farm j, km
    harvest  = jjbigharvest    # element [i,j] is harvest from farm i in week j, tons
    
    )

attach(params)

source("schedule_funcs.R")
source("cost_functions.R")
