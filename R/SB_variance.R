SB_variance<-function(data,block_length){

  #
  #  Function to compute the stationary bootstrap estimate of
  #  V[ sqrt(T)*Xbar ] (ie: the long-run variance) ANALYTICALLY
  #
  #  Using Lemma 1 of Politis and Romano (1994)
  #
  # INPUTS:   data, a TxN matrix of data
  #           block_length, a scalar, the average block length in the stationary bootstrap
  #
  # OUTPUTS,  out1, a NxN matrix, the estimated long-run covariance matrix of the data
  #
  #
  #  Andrew Patton
  #
  #  4 May, 2008

  T <- nrow(data)
  n <- ncol(data)
  for(i in 1:n){
    data[,i] <- data[,i] -mean(data[,i])
  }

  data <- rbind(data,data)
  out1 <- (t(data[1:T,])%*%as.matrix(data[1:T,]))/T
  for(ii in 1:(min(n,T)-1)){
    tmp_1 <- (1-ii/n)*((1-1/block_length)^ii)

    tmp_2 <- t(data[1:T,])
    tmp_3 <- data[(1+ii):(T+ii),]
    tmp_4 <- (tmp_2%*%tmp_3)/T

    tmp_5 <- t(data[(1+ii):(T+ii),])
    tmp_6 <- data[1:T,]
    tmp_7 <- (tmp_5%*%tmp_6)/T

    out1 <- out1 + tmp_1*(tmp_4+tmp_7)
  }
  return(out1)

}
