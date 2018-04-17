\name{wolak}
\alias{wolak}
\title{Testing inequality constraints in linear econometric models}
\description{
  \code{wolak} implements two tests from Wolak (1989, JoE) of inequality constraints in linear econometric models.

  \strong{Test 1:}
  \eqn{H0*: d1 >= 0, d2 >= 0, ..., dK >= 0}
  vs.
  \eqn{H1*: (d1, d2, ..., dK) in R^K, (ie: general alternative)}

  \strong{Test 2:}
  \eqn{H0**: d1 = d2 = ... = dK = 0}
  vs.
  \eqn{H1**: d1 > 0, d2 > 0, ..., dK > 0.}
}
\usage{
wolak(data, increasing = TRUE, difference = FALSE, wolakRep = 100)
}
\arguments{
  \item{data}{an object of class \code{"\link{matrix}"} (or one that
    can be coerced to that class): asset returns or differences in asset returns for the sorting application.}

  \item{increasing}{An object of class \code{"\link{logical}"}: Assume an increasing or a decreasing pattern in monotonicity for the sorted portfolios. If a decreasing pattern is assumed, then \eqn{H0*} of Test 1 changes to \eqn{H0*: d1 <= 0, d2 <= 0, ..., dK <= 0} and respectively \eqn{H1**} of Test 2 changes to \eqn{H1**: d1 < 0, d2 < 0, ..., dK < 0.}}

  \item{difference}{An object of class \code{"\link{logical}"}: If \code{data} is already differences in asset returns, use TRUE. Otherwise \code{data} will be transformed to difference returns \eqn{r_p(n+1) - r_p(n)} between portfolio \eqn{n+1 } and portfolio \eqn{n}}

  \item{wolakRep}{A numeric scalar, stating the number of simulations to use to estimate the weight function in the weighted-sum of chi-square variables.}
}
\details{
  Currently supported as input type of \code{data} are classes \code{"\link{matrix}"},
  \code{"\link{data.frame}"}, \code{ts}, \code{xts} and \code{zoo}.

  Using demo data shows for \code{wolakRep}, that results do not change much at all for 100 or 1000 simulations, but the running time
  dramatically increases with the number of simulations. However, for robust results a minimum of 100 runs is highly recommended.

  The HAC estimator of the covariance matrix of follows the adjustment of Newey-West (1987, 1994).
  The kernel ues is "Bartlett". See \code{\link[sandwich:NeweyWest]{NeweyWest}} for further information.
}
\value{
  \code{wolak} returns an object of \code{\link{class}} \code{"list"}.

  The returning list contains p-values for the
  following components:

  \item{TestOnePvalueWolak:}{p-value for \eqn{H0*} of Test 1.}
  \item{TestTwoPvalueWolak:}{p-value for \eqn{H0**} of Test 2.}

}

\references{
  Wolak, Frank A. (1989):
  Testing Inequality Constraints in Linear Econometric Models.
  \emph{Journal of Econometrics}, \bold{41}, p. 205--235.
  \doi{10.1016/0304-4076(89)90094-8}.
}

\examples{
## load demo data and apply Wolak tests
\donttest{
data(demo_returns)
tmp <- wolak(demo_returns)
tmp$TestOnePvalueWolak
}
## transform existing data (asset returns) into difference returns before applying wolak()
## as data is finally in difference returns, appy wolak() with difference = TRUE

\donttest{
data <- demo_returns[, 2:ncol(demo_returns)] - (demo_returns[, 1:(ncol(demo_returns) - 1)])
wolak(data, difference = TRUE)
}
}
