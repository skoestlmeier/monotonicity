newey_west <- function(data,lag){

  #
  # Newey-West estimator of V[ n^(-1/2)*sum(data) ]
  # (equals, asymptotically, cov(data) if the data are uncorrelated)
  #
  #  Andrew Patton
  #
  #  Tuesday 11 nov, 2003

  args <- as.list(match.call())
  args_length <- length(args)-1

  T <- nrow(data)
  K <- ncol(data)

  if(args_length < 2){
    lag <- floor(4*(T/100)^(2/9))
  }

  data <- data - c(rep(1,T))%*%t(colMeans(data))
  B0 <- (t(data)%*%data)/T
  for(ii in 1:lag){
    B1 <- (t(data[(1+ii):nrow(data),])%*%data[1:(nrow(data)-ii),])/T
    B0 <- B0 + (1-(ii/(lag+1)))*(B1+t(B1))
  }
  return(B0)
}
