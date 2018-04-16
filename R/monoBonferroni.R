monoBonferroni <- function(data, difference = FALSE){

  if (missing(data)) {
    stop("Variable 'data' is missing.")
  }

  data <- matrix_conversion(data)

  if(!is(difference,"logical")){
    stop("The variable 'difference' must be logical.")
  }

  if(!difference){
    data <- data[, 2:ncol(data)] - (data[, 1:(ncol(data) - 1)])
  }

  T <- nrow(data)
  K <- ncol(data)

  muhat <- colMeans(data)   # unconstrained estimate of mu
  lag <- floor(4*(T/100)^(2/9))
  omegahat <- newey_west(data,lag=lag)/T    # HAC estimator of the covariance matrix of muhat

  tstats <- muhat/(sqrt(diag(omegahat)))

  # below are "Bonferroni p-values", in the sense that we reject the null if
  # they are less than the size of the test. NOTE of course that unlike usual
  # p-vals these won't be Unif(0,1) under the null. In fact, they do not even
  # have to lie in [0,1] - they could be bigger than 1.

  result_1 <- K*pnorm(min(tstats))    # if this is less than alpha (size of test) then reject H0 in favour of H1
  result_2 <- K*pnorm(-max(tstats))   # if this is less than alpha (size of test) then reject H0* in favour of H1*

  # correct results if they are not in [0,1]
  if(result_1 < 0){
    result_1 <- 0
  }else if(result_1 > 1){
    result_1 <- 1
  }

  if(result_2 < 0){
    result_2 <- 0
  }else if(result_2 > 1){
    result_2 <- 1
  }

  out <- list(as.numeric(result_1),as.numeric(result_2))
  names(out) <- c("TestOnePvalBonferroni","TestTwoPvalBonferroni")
  return(out)

}
