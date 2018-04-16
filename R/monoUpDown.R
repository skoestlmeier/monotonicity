monoUpDown <- function(data, difference = FALSE, bootstrapRep = 1000, block_length){


  #  OUTPUTS: out1, a 4x2 vector, the bootstrap p-values from a test for a  monotonic *increaasing* relationship, and a monotonic *decreasing* relationship.
  #               First two rows for squared diffs, second two rows for abs diffs
  #               First col not studentised, second col studentised

  out <- matrix(c(rep(-999.99,8)),ncol=2)

  if (missing(data)) {
    stop("Variable 'data' is missing.")
  }

  data <- matrix_conversion(data)

  if(!is(difference,"logical")){
    stop("The variable 'difference' must be logical.")
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

  T <- nrow(data)
  n <- ncol(data)

  if (n > 15) {
    stop("Stocks can be sorted in maximum 15 portfolios.")
  }

  # differences across the columns of the data
  if(!difference){
  diffdata <- matrix(NA,nrow=nrow(data),ncol=ncol(data)-1)
  for (i in 2:(ncol(data))){
    diffdata[,i-1] <- data[,i] - data[,i-1]
  }}else{
    diffdata <- data
  }

  dmuhat <- colMeans(diffdata)
  indic_pos <- (dmuhat>0)
  indic_neg <- (dmuhat<=0)

  Jstatpos2 <- sum((dmuhat^2)*indic_pos)    # test stat for an increasing relationship on real data
  Jstatneg2 <- sum((dmuhat^2)*indic_neg)    # test stat for an decreasing relationship on real data

  Jstatpos1 <- sum(abs(dmuhat)*indic_pos)   # test stat for an increasing relationship on real data
  Jstatneg1 <- sum(abs(dmuhat)*indic_neg)   # test stat for an decreasing relationship on real data

  SBvariance <- SB_variance(diffdata,block_length)    # stat boot covariance matrix of all differences
  diffdatastd <- diffdata/(c(rep(1,T))%*%(sqrt(t(diag(SBvariance)))))   # studentised differences
  dmuhatstd <- colMeans(diffdatastd)

  # following test stats are all based on studentised data
  Jstatpos2std <- sum((dmuhatstd^2)*indic_pos)    # test stat for an increasing relationship on real data
  Jstatneg2std <- sum((dmuhatstd^2)*indic_neg)    # test stat for an decreasing relationship on real data

  Jstatpos1std <- sum(abs(dmuhatstd)*indic_pos)   # test stat for an increasing relationship on real data
  Jstatneg1std <- sum(abs(dmuhatstd)*indic_neg)   # test stat for an decreasing relationship on real data

  JstatsALL <- matrix(cbind(Jstatpos2,Jstatneg2,Jstatpos1,Jstatneg1,Jstatpos2std,Jstatneg2std,Jstatpos1std,Jstatneg1std),nrow=4,ncol=2)

  # generating the time indices for the bootstrapped data
  bootdates <- statBootstrap(T,bootstrapRep,block_length)
  temp <- matrix(rep(0,4000),nrow = bootstrapRep,ncol=4)
  tempS <- matrix(rep(0,4000),nrow = bootstrapRep,ncol=4)
  for(ii in 1:(n-1)){
    temp2 <- diffdata[,ii]
    res <- matrix(temp2[bootdates],ncol=ncol(bootdates),nrow=nrow(bootdates))
    me <- colMeans(res)
    dmuhatB <- me - dmuhat[ii]    # computing mean using bootstrapped data, then re-centering using actual means

    temp[,1] <- temp[,1] + (dmuhatB^2)*(dmuhatB>0)
    temp[,2] <- temp[,2] + (dmuhatB^2)*(dmuhatB<0)
    temp[,3] <- temp[,3] +(abs(dmuhatB))*(dmuhatB>0)
    temp[,4] <- temp[,4] +(abs(dmuhatB))*(dmuhatB<0)

    temp2 <- diffdatastd[,ii]
    res <- matrix(temp2[bootdates],ncol=ncol(bootdates),nrow=nrow(bootdates))
    me <- colMeans(res)
    dmuhatstdB <- me - dmuhatstd[ii]    # computing mean using bootstrapped data, then re-centering using actual means

    tempS[,1] <- tempS[,1] + (dmuhatstdB^2)*(dmuhatstdB>0)
    tempS[,2] <- tempS[,2] + (dmuhatstdB^2)*(dmuhatstdB<0)
    tempS[,3] <- tempS[,3] +(abs(dmuhatstdB))*(dmuhatstdB>0)
    tempS[,4] <- tempS[,4] +(abs(dmuhatstdB))*(dmuhatstdB<0)
  }

  out[1,1] <- mean(temp[,1]>Jstatpos2)
  out[2,1] <- mean(temp[,2]>Jstatneg2)
  out[3,1] <- mean(temp[,3]>Jstatpos1)
  out[4,1] <- mean(temp[,4]>Jstatneg1)

  out[1,2] <- mean(tempS[,1]>Jstatpos2std)
  out[2,2] <- mean(tempS[,2]>Jstatneg2std)
  out[3,2] <- mean(tempS[,3]>Jstatpos1std)
  out[4,2] <- mean(tempS[,4]>Jstatneg1std)

  colnames(out) <- c("not_studentised","studentised")
  rownames(out) <- c("squared_diffs_increasing","squared_diffs_decreasing","abs_diffs_increasing","abs_diffs_decreasing")
  return(out)
}
