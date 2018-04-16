\name{monoUpDown}
\alias{monoUpDown}
\title{Up and Down test}
\description{
  \code{monoUpDown} implements the 'Up and Down' tests from Patton & Timmermann (2010, JFE) based on:

  (1) sum of squared differences for positive diffs and negative diffs,
  (2) sum of absolute differences for positive diffs and negative diffs,

and uses the stationary bootstrap method from Politis & Romano (1994, JASA).}
\usage{
monoUpDown(data, difference = FALSE, bootstrapRep = 1000, block_length)
}
\arguments{
  \item{data}{an object of class \code{"\link{matrix}"} (or one that
    can be coerced to that class): asset returns or differences in asset returns which are sorted in a maximum of 15 portfolios. Each column of the matrix 'data' represents a single portfolio. \code{data} is therefore limited to a 15 columns.}

      \item{difference}{An object of class \code{"\link{logical}"}: If \code{data} is already differences in asset returns, use TRUE. Otherwise \code{data} will be transformed to difference returns \eqn{r_p(n+1) - r_p(n)} between portfolio \eqn{n+1 } and portfolio \eqn{n}}

  \item{bootstrapRep}{A numeric scalar: the number of bootstrap samples.}

  \item{block_length}{A numeric scalar: The average length of the block to usefor the stationary bootstrap. This parameter is related to how much serial correlation is in your data. Use 10/6/3/2 as the block length if data is measured in daily/monthly/quarterly/annual returns.}
}
\value{
  \code{monoUpDown} returns an object of \code{\link{class}} \code{"matrix"}:

  \item{\code{"matrix"}:}{A named 4x2 matrix with the bootstrap p-values from a test for a  monotonic relationship. The first row contains p-values for squared diffs in an assumed increasing monotonic pattern, the second row respectively for a decreasing pattern. The third row contains p-values for absolute differences in an assumed increasing monotonic pattern, the fourth row respectively for a decreasing pattern. The first column gives p-values which are not studentised, the second column the equivalent studentised p-values.}
}

\references{
  Patton, A. and Timmermann, A. (2010):
  Monotonicity in asset returns: New testes with applications to the term structure, the CAPM, and portfolio sorts.
  \emph{Journal of Financial Economics}, \bold{98}, No. 3, p. 605--625.
  \doi{10.1016/0304-4076(89)90094-8}.

  Wolak, Frank A. (1989):
  Testing Inequality Constraints in Linear Econometric Models.
  \emph{Journal of Econometrics}, \bold{41}, p. 205--235.
  \doi{10.1016/j.jfineco.2010.06.006}.
}

\examples{
## load demo data and apply monoUpDown with daily data, which are not yet in differences
data(demo_returns)
test <- monoUpDown(demo_returns,block_length = 10)
}
