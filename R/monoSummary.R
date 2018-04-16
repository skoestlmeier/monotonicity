monoSummary <-  function(data, bootstrapRep = 1000, wolakRep = 100, increasing = TRUE, difference = FALSE, plot = FALSE, block_length){

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

  if(!(is.atomic(wolakRep) & length(wolakRep) == 1 & is.numeric(wolakRep))){
    stop("The variable 'wolakReP' must be a numeric scalar.")
  }

  if (wolakRep < 1) {
    stop("The number of wolak simulations must be positive.")
  }

  if (wolakRep < 100) {
    warning("For robust results there should be a minimum of 100 runs of the wolak simulation.")
  }

  if(!is(increasing,"logical")){
    stop("The variable 'difference' must be logical.")
  }

  if(!is(difference,"logical")){
    stop("The variable 'difference' must be logical.")
  }

  if(!is(plot,"logical")){
    stop("The variable 'plot' must be logical.")
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

    table1b <- t(c(rep(-999.99, 9)))
    table1b[, 1] <- mean(data[, ncol(data)] - data[, 1])

    temp <- monoRelation(data, bootstrapRep, increasing, difference, block_length)
    table1b[1, 2:5] <- t(temp[, 2])

    temp <- monoUpDown(data, difference, bootstrapRep, block_length)
    table1b[1, 6:7] <- t(temp[3:4, 2])

    temp <- wolak(data, increasing, difference, wolakRep)
    table1b[1, 8] <- temp$TestOnePvalueWolak

    temp <- monoBonferroni(data, difference)
    table1b[1, 9] <- temp$TestOnePvalBonferroni
    colnames(table1b) <-  c("Top-Bottom", "t_stat", "t_pval", "MR_pval", "MRall_pval", "UP_pval", "DOWN_pval", "Wolak_pval", "Bonferroni_pval")
    cat("\n")
    cat("Table: Test of monotonicity for returns on sorted portfolios\n")
    cat("\n")

    table1b <- specify_decimal(table1b, 3)
    table1b <- as.data.frame(table1b)
    if(plot){
    plot(
      1:10,
      colMeans(data),
      type = "b",
      xlab = "Portfolio Number",
      ylab = "Average Return",
      main = paste(
        "Average returns on sorted portfolio returns, MR p-value = ",
        table1b$MR_pval
      )
    )
    }
    return(table1b)
  }
