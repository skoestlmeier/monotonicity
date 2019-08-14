\name{monoSummary}
\alias{monoSummary}
\title{Summary of Patton and Timmermann monotonicity (JoE, 2010) tests}
\description{
  \code{monoSummary} implements the test for monotonicity in asset returns, based on portfolio sorts in (JoE, 2010)
}
\usage{
monoSummary(data, bootstrapRep = 1000, wolakRep = 100,
  increasing = TRUE, difference = FALSE, plot = FALSE, block_length, zero_treshold = 1e-6)
}
\arguments{
  \item{data}{an object of class \code{"\link{matrix}"} (or one that
    can be coerced to that class): asset returns or differences in asset returns which are sorted in a maximum of 15 portfolios. Each column of the matrix 'data' represents a single portfolio. \code{data} is therefore limited to a 15 columns.}

  \item{bootstrapRep}{A numeric scalar: the number of bootstrap samples.}

    \item{wolakRep}{A numeric scalar, stating the number of simulations to use to estimate the weight function in the weighted-sum of chi-square variables.}

      \item{increasing}{An object of class \code{"\link{logical}"}: Assume an increasing or a decreasing pattern in monotonicity for the sorted portfolios.}

  \item{difference}{An object of class \code{"\link{logical}"}: If \code{data} is already differences in asset returns, use TRUE. Otherwise \code{data} will be transformed to difference returns \eqn{r_p(n+1) - r_p(n)} between portfolio \eqn{n+1 } and portfolio \eqn{n}}

  \item{plot}{An object of class \code{"\link{logical}"}: If \code{plot} is TRUE, a plot is generated of the average returns on sorted portfolios with the p-value of the test on monotonicity from \code{monoRelation.R}. Otherwise \code{data} will be transformed to difference returns \eqn{r_p(n+1) - r_p(n)} between portfolio \eqn{n+1 } and portfolio \eqn{n}}

    \item{block_length}{A numeric scalar: The average length of the block to usefor the stationary bootstrap. This parameter is related to how much serial correlation is in your data. Use 10/6/3/2 as the block length if data is measured in daily/monthly/quarterly/annual returns.}
    
      \item{zero_treshold}{A numeric scalar, being the treshold for comparing solution values of a non-linear optimization in the Wolak (1989, JoE) test against zero. See section DETAILS for further information.}

}

\details{
  Internally, a non-linear optimization using \code{"\link{constrOptim}"} is used for the Monte-Carlo simulation within the Wolak (1989, JoE) test. The resulting values of the solution are close to zero, but due to the used machine precision numerically differnt from zero. For this reason, we suggest a treshold value close to zero. The default value is \eqn{1e-6}, so all resulting solutions smaller than the treshold value are treated as being zero. The default treshold value is consistent with the data-set and results of Patton and Timmermann (JoE, 2010). Of course, the appropriate treshold value can differ across applications (e.g. run the code on one set of data, and then the same data/100).
}

\value{
  \code{monoSummary} returns an object of \code{\link{class}} \code{"data.frame"}.

  The returning value of \code{"monoSummary"} is a \code{"data.frame"} containing the
  following components:

  \item{TopMinusBottom}{Mean difference return between top and bottom portfolio.}
  \item{t_stat}{the residuals, that is response minus fitted values.}
  \item{t_pval}{the fitted mean values.}
  \item{MR_pval}{the numeric rank of the fitted linear model.}
  \item{MRall_pval}{the numeric rank of the fitted linear model.}
  \item{UP_pval}{studentized p-value from Patton and Timmermanns (JoE, 2010) "Up and Down" test for assumed increasing monotonicity pattern and using absolute difference returns.}
  \item{DOWN_pval}{studentized p-value from Patton and Timmermanns (JoE, 2010) "Up and Down" test for assumed decreasing monotonicity pattern and using absolute difference returns.}
  \item{Wolak_pval}{p-value "TestOnePvalueWolak" for \eqn{H0*} of Test 1 in \code{wolak.R}}
  \item{Bonferroni_pval}{p-value for \eqn{H0*} of Test 1 from \code{monoBonferroni.R}.}
}

\seealso{
  \code{\link{monoRelation}},
  \code{\link{monoUpDown}},
  \code{\link{wolak}}.
}

\references{
  Patton, A. and Timmermann, A. (2010):
  Monotonicity in asset returns: New testes with applications to the term structure, the CAPM, and portfolio sorts.
  \emph{Journal of Financial Economics}, \bold{98}, No. 3, p. 605--625.
  \doi{10.1016/j.jfineco.2010.06.006}.
  
  Wolak, Frank A. (1989):
  Testing Inequality Constraints in Linear Econometric Models.
  \emph{Journal of Econometrics}, \bold{41}, p. 205--235.
  \doi{10.1016/0304-4076(89)90094-8}.
}

\examples{
## load daily non-difference return data.
## test an increasing pattern of monotonicity
\donttest{
data(demo_returns)
monoSummary(demo_returns, increasing = TRUE, block_length = 10)
}
}
