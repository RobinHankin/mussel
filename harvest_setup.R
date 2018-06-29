## scheduling problem for mussel collection

## First define harvest size:
stop()
yield <- c(f8463=142, f8468=162 ,f8487=40 ,f8391=39, f8378=32, f8344=162, f8337=23)  
farmnames <- names(yield)
harvest <- kronecker(t(rep(1,9)),yield)

no_of_blocks <- ncol(harvest)
rownames(harvest) <- farmnames
colnames(harvest) <- paste("block", seq_len(no_of_blocks), sep="")

 ## set up inter-farm distances:
a <- as.matrix(read.table("farm_dist_matrix.txt"),header=FALSE)
farmdist <- a[-1,-1]

no_of_farms <- 7


## farmdist is a matrix of distances (symmetric)


basedist <- a[1,-1]
names(basedist) <- farmnames

