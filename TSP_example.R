## This file shows a "bare-bones" example of TSP in use, using
## farm_dist_matrix.txt.  It is not used in the rest of the software,
## it is just a handy reference.


library("TSP")

M <- as.matrix(read.table("farm_dist_matrix.txt"))

## first, try visiting *every* farm on the list:

##
allfarms <- solve_TSP(TSP(M))
cat("Tour itinerary: \n")
print(cut_tour(allfarms, 'base'),collapse= " ")
cat("\n total tour length: \n")
print(tour_length(allfarms))

## Now visit only say three farms:

v <- c(0,1,1,0,0,0,1)   # visit farms 2,3,7.
v <- c(0,1,0,0,0,0,0)   # visit farms 2,3,7.



Mshort <- M[c(which(v>0),8),c(which(v>0),8)]  # NB: not M[v,v] as the labels are wrong

somefarms <- solve_TSP(TSP(Mshort))
cat("Short tour itinerary: \n")
print(cut_tour(somefarms, 'base'),collapse= " ")
cat("\n total tour length: \n")
print(tour_length(somefarms))
