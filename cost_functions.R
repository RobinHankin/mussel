## Defines objective(), which is the objective function minimized by
## optim() in mussel.R

travel_cost_one_block <- function(v, harvest_one_block){
  km <- kilometers_travelled_one_block(v)
  travelling_hours <- km/ boat_speed
 
  processing_hours <- sum(harvest_one_block[v>0])/tons_per_hour
  total_hours <- travelling_hours + processing_hours
 
  return(travelling_hours * costperhour + (total_hours>maxhours)*costofoverrun)
}

kilometers_travelled_one_block <- function(v){
  howmanynonzero <- sum(v>0)
  n <- nrow(farmdist)
    if(howmanynonzero==0){
      return(0)  # no travel!
    } else {
      Mshort <- farmdist[c(which(v>0),n),c(which(v>0),n)]  # NB: not M[v,v] as the labels are wrong
      return(tour_length(solve_TSP(TSP(Mshort))))
    }
}

travel_cost <- function(S,verbose=FALSE){
    ##  out <- apply(S,2,travel_cost_one_block)
    out <- rep(0,ncol(S))
    for(j in seq_len(ncol(S))){
        out[j] <- travel_cost_one_block(S[,j],harvest[,j])
    }
  if(verbose){
    return(out)
  } else {
    return(sum(out))
  }
}

profit <- function(S, verbose=FALSE){
  ## basic total harvest would be  return(sum(harvest[S>0]))
  out <- ( harvest * (S>0)) %>% colSums %>% pmin(capacity) 
    if(verbose){
        return(out*commodity_price)
    } else {
        return(sum(out*commodity_price))
    }
}
  
objective <- function(Svec,prob=0.01){  # minimize the objective
    S <- matrix(Svec,no_of_farms,no_of_blocks)
    out <- travel_cost(S) - profit(S)
    if(runif(1) < prob){
        print(paste("travel: ",round(travel_cost(S)),sep=""))
        print(paste("profit: ",round(profit(S)),sep=""))
        print(paste("farms visited: ",sum(S),sep=""))
    }
    return(out)
}

get_itinerary_one_block <- function(v){
  if(any(v>0)){
    n <- no_of_farms + 1   # params is attached
    Mshort <- farmdist[c(which(v>0),n),c(which(v>0),n)]  # NB: not M[v,v] as the labels are wrong
    return(cut_tour(solve_TSP(TSP(Mshort)),'base'))
  } else {
    return("no travel")
  }
}
    
