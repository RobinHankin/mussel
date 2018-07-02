# Various utilities to manipulate a schedule.  The functions at the
## end,add1(), sub1(), munge(), and swap(), are the ones called by the
## gradient function.

is_ok_single_row <- function(v){  ## checks a single row of a schedule for consistency: 
    nonz <- which(v>0)
    if(any(nonz)){
        for(i in nonz){
            if(sum(v[seq(from=max(1,i-recovery),to=min(i+recovery,length(v)))]>0)>1){
                return(FALSE)
            }
        } # i loop closes
        return(TRUE)        
    } else {  # all zero!
        return(TRUE)
    }
}

is_ok <- function(S){  # tests an entire schedule for consistency
    return(all(apply(S,1,is_ok_single_row)) )
}


add1_single <- function(v){
    ## Randomly adds a farm to a block if  possible (if not, return with no change)
    if(any(v==0)){
        i <- sample(which(v==0),1)
        v[i] <- 1
    }
    return(v)
}
    
add1_try <- function(S){   # randomly add a farm to a random week irregardless of sensibleness
    j <- sample(ncol(S),1)
    S[,j] <- add1_single(S[,j])
    return(S)
}

sub1_single <- function(v){
 ## Randomly subtracts a farm from a block if possible (if not, return
 ## with no change)

    if(any(v>0)){
        i <- sample(which(v>0),1)
        v[i] <- 0
    }
  return(v)
}
    
swap_single <- function(v){  # randomly swaps two farms in one block
    if(sum(v>0)>1){
        ij <- sample(which(v>0),2,replace=FALSE)
        swap     <- v[ij[1]]
        v[ij[1]] <- v[ij[2]]
        v[ij[2]] <- swap
    }
    return(v)
}

munge_single <- function(v){

    ## operates on one row of a schedule, referring to a particular
    ## farm.  "Munging" means to change the block in which that farm
    ## is visited.
    if(any(v==0) & any(v>0)){
        i <- sample(which(v==0),1)
        j <- sample(which(v> 0),1)
        swap <- v[i]
        v[i] <- v[j]
        v[j] <- swap
    }
    return(v)
}

munge_try <- function(S){  # Tries to munge a schedule; might return an inadmissible schedule
    i <- sample(nrow(S),1)
    S[i,] <- munge_single(S[i,])
    return(S)
}

## The four functions below are the ones that are called by the
## gradient function: add1(), sub1(), and swap().

add1 <- function(S,n=100){  # tries 100 times to add a farm
    for(i in seq_len(n)){
        out <- add1_try(S)
        if(is_ok(out)){ return(out) }
    } # i loop closes
    return(S)  # return the original schedule
}

sub1 <- function(S){   # randomly remove a farm in a random week
    j <- sample(ncol(S),1)
    S[,j] <- sub1_single(S[,j])
    return(S)
}


munge <- function(S,n=100){  # tries 100 times to find a munged schedule that is admissible
    for(i in seq_len(n)){
        out <- munge_try(S)
        if(is_ok(out)){ return(out) }
    } # i loop closes
    return(NA)
}


