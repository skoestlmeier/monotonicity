\name{monoRelation}
\alias{monoRelation}
\title{Testing the monotonic relationship in asset returns}
\description{
  \code{monoRelation} implements the 'monotonic relationship' tests from Patton & Timmermann (2010, JFE). We define \eqn{\Delta_i = E[r_(i,t)] - E[r_(i-1,t)]} and test

  \eqn{H0: \Delta <= 0}

  vs.

  \eqn{H1: min_(i = 1..N){\Delta_i} > 0}

}

\usage{
monoRelation(data, bootstrapRep = 1000, increasing = TRUE,
  difference = FALSE, block_length)
}

\arguments{
  \item{data}{an object of class \code{"\link{matrix}"} (or one that
    can be coerced to that class): asset returns or differences in asset returns which are sorted in a maximum of 15 portfolios. Each column of the matrix 'data' represents a single portfolio. \code{data} is therefore limited to a 15 columns.}

  \item{bootstrapRep}{A numeric scalar: the number of used bootstrap samples.}

  \item{increasing}{An object of class \code{"\link{logical}"}: Assume an increasing or a decreasing pattern in monotonicity for the returns of the sorted portfolios.}

  \item{difference}{An object of class \code{"\link{logical}"}: If \code{data} is already differences in asset returns, use TRUE. Otherwise \code{data} will be transformed to difference returns \eqn{r_p(n+1) - r_p(n)} between portfolio \eqn{n+1 } and portfolio \eqn{n}}

  \item{block_length}{A numeric scalar: The average length of the block to usefor the stationary bootstrap. This parameter is related to how much serial correlation is in your data. Use 10/6/3/2 as the block length if data is measured in daily/monthly/quarterly/annual returns.}
}

\value{
  \code{monoRelation} returns an object of \code{\link{class}} \code{"matrix"}.

  The returning matrix consists of the following components:

  \item{matrix}{a 4x2 matrix. The values of the first column are non-studentised, the values of the second column are studentised.
  Row (1): the t-statistic associated with a t-test that \eqn{\Delta_i <= 0}
  Row (2): the p-value associated with a t-test that \eqn{\Delta_i <= 0}
  Row (3): the MR test p-value from the proposed test, based on adjacent portfolios
  Row (4): the MR test p-value from the proposed test, on all pair-wise portfolio comparisons}
}

\references{
  Patton, A. and Timmermann, A. (2010):
  Monotonicity in asset returns: New testes with applications to the term structure, the CAPM, and portfolio sorts.
  \emph{Journal of Financial Economics}, \bold{98}, No. 3, p. 605--625.
  \doi{10.1016/0304-4076(89)90094-8}.
}

\examples{
## load non-difference return data and apply test with daily returns.
data(demo_returns)
monoRelation(demo_returns, block_length = 10)
}
