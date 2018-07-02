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
    v %<>% make_triplist_single()
    howmanynonzero <- sum(v>0)
    if(howmanynonzero==0){return(0)}  # no travel!

    if(howmanynonzero==1){  # travel to one farm.
        return(2*sum(basedist[which(v==1)]))  # "*2" because we make a return trip
    }

    out <- 0

    for(i in seq_along(max(v)-1)){
        out <- out + farmdist[which(v==i), which(v==i+1)]
    }
    return(
        out + basedist[which(v==1)] + basedist[which(v==max(v))]
        )
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
  
objective <- function(Svec){  # minimize the objective
    S <- matrix(Svec,no_of_farms,no_of_blocks)
    out <- travel_cost(S) - profit(S)
    return(out)
}
