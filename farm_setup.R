## scheduling problem for mussel collection
## First define harvest size:

yield <- c(f8463=142, f8468=162 ,f8487=40 ,f8391=39, f8378=32, f8344=162, f8337=23)  
farmnames <- names(yield)
jjharvest <- kronecker(t(rep(1,9)),yield)

no_of_blocks <- ncol(jjharvest)
rownames(jjharvest) <- farmnames
colnames(jjharvest) <- paste("block", seq_len(no_of_blocks), sep="")

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
