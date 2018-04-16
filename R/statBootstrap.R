statBootstrap <- function(T, bootstrapRep = 1000, block_length){

  if (missing(T)) {
    stop("The number of time series observations T is missing.")
  }

  if(!(is.atomic(T) & length(T) == 1 & is.numeric(T))){
    stop("The variable 'T' must be a numeric scalar.")
  }

  if (T<1) {
    stop("The number of time series observations T must be at least one.")
  }

  if(!(is.atomic(bootstrapRep) & length(bootstrapRep) == 1 & is.numeric(bootstrapRep))){
    stop("The variable 'bootstrapRep' must be a numeric scalar.")
  }

  if (bootstrapRep < 1) {
    stop("There must be at least one run of a bootstrap simulation.")
  }

  if (missing(block_length)) {
    stop("Value of the average block length used in the stationary bootstrap sample is missing.")
  }
  if (!block_length %in% c(10,6,3,2)) {
    stop("The variable 'block_length' must be a number from the set {2,3,6,10} for annual/quarterly/monthly/daily return data.")
  }

  out1 <- matrix(rep(-999.99,T*bootstrapRep),nrow=T,ncol=bootstrapRep)

  # BOOTSTRAPPING THE SAMPLE AND GENERATING THE BOOTSTRAP DIST'N OF THE THREE MEASURES
  for(bb in 1:bootstrapRep){
    random <- runif(1)
    temp <- ceiling(random*T)
    out1[1,bb] <- temp
    for(tt in 2:T){
      temp2 <- runif(1)
      if(temp2 > 1/block_length){ # then we just take next obs
        if(temp==T){              # loop back to first obs if running past T
          temp <- 1
        }else{
          temp <- temp+1
        }
      }else{
        random_tmp <- runif(1)
        temp <- ceiling(random_tmp*T)
      }
      out1[tt,bb] <- temp
    }
  }
  return(out1)
}
