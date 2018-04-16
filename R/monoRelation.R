monoRelation <- function(data, bootstrapRep = 1000, increasing = TRUE, difference = FALSE, block_length) {

    # OUTPUTS: out1, a 4x2 vector, (1) the t-statistic associated with a t-test that mu_1=mu_n,
    #                              (2) the p-value associated with a t-test that mu_1=mu_n,
    #                              (3) the MR test p-value from the proposed test (non-studentised)
    #                              (4) the MR test p-value from the proposed test, on ALL pair-wise comparisons (non-studentised)
    #                              first column is non-studentised, second column is studentised (NOTE: tstats and pvals are not affected by studentisation, so are the same)

    #requireNamespace(sandwich)

    out <- matrix(c(rep(-999.99, 8)), ncol = 2)

    if (missing(data)) {
      stop("Variable 'data' is missing.")
    }

    data <- matrix_conversion(data)

    if(!(is.atomic(bootstrapRep) & length(bootstrapRep) == 1 & is.numeric(bootstrapRep))){
      stop("The variable 'bootstrapRep' must be a numeric scalar.")
    }

    if (bootstrapRep < 1) {
      stop("There must be at least one run of a bootstrap simulation.")
    }

    if(!is(increasing,"logical")){
      stop("The variable 'difference' must be logical.")
    }

    if(!is(difference,"logical")){
      stop("The variable 'difference' must be logical.")
    }

    # direction
    #           =  1 if want to test for an *increasing* relationship,
    #           = -1 if want to test for a *decreasing* relationship,
    #           =  2, if data are already in differences (eg: for two-way sorts) and want to test for an *increasing* relationship
    #           = -2, if data are already in differences (eg: for two-way sorts) and want to test for an *decreasing* relationship


    if(difference){
      if(increasing){
        direction <- 2
      }else{
        direction <- -2
      }
    }else{
      if(increasing){
        direction <- 1
      }else{
        direction <- -1
      }
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
      stop("Stocks can be sorted in maximum 15 categories")
    }

    if (abs(direction) < 2) { # then need to difference the data
      diffdata <- matrix(NA, nrow = nrow(data), ncol = ncol(data) - 1)
      for (i in 2:(ncol(data))) {
        diffdata[, i - 1] <- data[, i] - data[, i - 1] # differences across the columns of the data
        diffdata <- diffdata * direction # changing the sign of these if want to look for a *decreasing* pattern rather than an *increasing*
      }
    } else{
      diffdata <- data # data are already in differences
      diffdata <- sign(direction) * diffdata # hanging the sign of these if want to look for a *decreasing* pattern rather than an *increasing* pattern
      n <- n + 1 # if data are already differenced, then this is like having one more column in the raw data
    }

    dmuhat <- colMeans(diffdata)

    # generating the time indices for the bootstrapped data:
    bootdates <- statBootstrap(T, bootstrapRep, block_length)

    # this is the long-run variance of diffdata, according to the stationary bootstrap (obtained analytically using Lemma 1 of PR(94)
    # I only have to compute this once, as it does not depend on the bootstrap random draws
    SBvariance <- SB_variance(diffdata, block_length)
    temp <- matrix(rep(-999.99, bootstrapRep * (n - 1)), nrow = bootstrapRep, ncol = (n - 1))
    tempS <- matrix(rep(-999.99, bootstrapRep * (n - 1)), nrow = bootstrapRep, ncol = (n - 1))

    for (ii in 1:(n - 1)) {
      temp2 <- diffdata[, ii]
      res <- matrix(temp2[bootdates], ncol = ncol(bootdates), nrow = nrow(bootdates))
      me <- colMeans(res)
      tmp <- me - dmuhat[ii]
      temp[, ii] <- tmp # the mean of each of the bootstrap shuffles of the original data, minus the mean of the original
      tempS[, ii] <- tmp / sqrt(SBvariance[ii, ii]) # studentising the difference using the SB estimate of its std deviation
    }

    temp <- apply(temp, 1, min) # looking at the minimum difference in portfolio means, for each of the bootstrapped data sets
    Jstat <- min(dmuhat) # the test statistic
    out[3, 1] <- mean(temp > Jstat) # the p-value associated with the test statistic

    tempS <- apply(tempS, 1, min) #looking at the minimum STUDENTISED difference in portfolio means, for each of the bootstrapped data
    JstatS <- min(dmuhat / (sqrt(diag(SBvariance)))) #the STUDENTISED test statistic
    out[3, 2] <- mean(tempS > JstatS) #the p-value associated with the STUDENTISED test statistic

    # if data are already in differences, then I cannot do the t-test. this must be done on the actual returns
    # now getting the t-statistic and p-value from the usual t-test
    if (abs(direction) < 2) {
      y <- direction * (data[, ncol(data)] - data[, 1])
      x <- c(rep(1, T))
      lag <- floor(4 * (T / 100) ^ (2 / 9))
      nwreg <- lm(y ~ x)

      nwout <- lmtest::coeftest(nwreg, sandwich::NeweyWest(nwreg, lag = lag, prewhite = FALSE))
      out[1, ] <- nwout[3] %*% t(c(1, 1))
      out[2, ] <- pnorm(-nwout[3]) %*% t(c(1, 1))
    }

    # 17apr08: running the test on all possible differences, rather than just the adjacent portfolios
    # this matrix will "stretch the diffs in adjacent portfolios to cover all
    # possible differences
    R <- diag(n - 1)
    for (ii in 2:(n - 1)) {   # looping through the block sizes (2 up to N-1)
      for (jj in 1:(n - 1 - ii + 1)) {    # looping through the starting column for blocks
        first <- t(rep(0, jj - 1))
        second <- t(rep(1, ii))
        third <- t(rep(0, n - 1 - ii - jj + 1))

        fourth <- cbind(first, second, third)
        R <- rbind(R, fourth)

      }
    }

    diffdata2 <- diffdata %*% t(R)
    dmuhat2 <- colMeans(diffdata2)
    temp <- matrix(rep(-999.99, bootstrapRep * (n * (n - 1) / 2)), nrow = bootstrapRep, ncol = (n * (n - 1) / 2))
    tempS <- matrix(rep(-999.99, bootstrapRep * (n * (n - 1) / 2)), nrow = bootstrapRep, ncol = (n * (n - 1) / 2))

    SBvariance <- SB_variance(diffdata2, block_length)

    # the mean of each of the bootstrap shuffles of the original data, minus the mean of the original data (the re-centering bit)
    for (ii in 1:((n * (n - 1)) / 2)) {
      temp2 <- diffdata2[, ii]
      res <-  matrix(temp2[bootdates], ncol = ncol(bootdates), nrow = nrow(bootdates))
      me <- colMeans(res)
      tmp <- me - dmuhat2[ii]
      temp[, ii] <- tmp

      # studentising the difference using the SB estimate of its std deviation
      tempS[, ii] <- tmp / sqrt(SBvariance[ii, ii])
    }

    temp <- apply(temp, 1, min)   # looking at the minimum difference in portfolio means, for each of the bootstrapped data sets
    Jstat <- min(dmuhat2)   # the test statistic
    out[4, 1] <- mean(temp > Jstat)   # the p-value associated with the test statistic

    tempS <- apply(tempS, 1, min)   # looking at the minimum STUDENTISED difference in portfolio means, for each of the bootstrapped data sets
    JstatS <- min(dmuhat2 / (sqrt(diag(SBvariance))))   # the STUDENTISED test statistic
    out[4, 2] <- mean(tempS > JstatS)   # the p-value associated with the STUDENTISED test statistic

    colnames(out) <- c("not_studentised","studentised")
    rownames(out) <- c("t-value","p-value","MR_p-value_AdjacentPortfolios","MR_p-value_AllPortfolios")

    return(out)
}
