
gradfunc <- function(Svec,n=100){   # randomly perturb schedule
  S <- matrix(Svec,no_of_farms,no_of_blocks)
    for(i in seq_len(n)){
        jj <- sample(4,1)
        if(jj==1){
            Snew <- munge(S)
        } else if(jj==2){
            Snew <- add1(S)
        } else if(jj==3){
            Snew <- sub1(S)
        } else if(jj==4){
            Snew <- swap(S)
        } else {
            stop("this cannot happen")
        }
        if(is_ok(Snew)){return(c(Snew))}
    }
    warning('no modification found')
    return(c(S))
}
