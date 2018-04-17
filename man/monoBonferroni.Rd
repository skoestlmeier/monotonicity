\name{monoBonferroni}
\alias{monoBonferroni}
\title{Test of weak monotonicity using Bonferroni bounds}
\description{
  \code{monoBonferroni} implements the test of weak monotonicity using Bonferroni bounds described in Patton & Timmermann (2010, JFE):
  \strong{Test 1:}
  \eqn{H0*: d1 >= 0, d2 >= 0, ..., dK >= 0}
  vs.
  \eqn{H1*: dj < 0  for some j=1,2,..,K}

  \strong{Test 2:}
  \eqn{H0**: d1 <= 0, d2 <= 0, ..., dK <= 0}
  vs.
  \eqn{H1**: dj > 0  for some j=1,2,..,K.}
}
\usage{
monoBonferroni(data, difference = FALSE)
}
\arguments{
  \item{data}{an object of class \code{"\link{matrix}"} (or one that
    can be coerced to that class): asset returns or differences in asset returns for the sorting application.}

      \item{difference}{An object of class \code{"\link{logical}"}: If \code{data} is already differences in asset returns, use TRUE. Otherwise \code{data} will be transformed to difference returns \eqn{r_p(n+1) - r_p(n)} between portfolio \eqn{n+1 } and portfolio \eqn{n}}
}

\value{
  \code{monoBonferroni} returns an object of \code{\link{class}} \code{"list"}

  The returning list contains p-values (see Note) using Bonferroni-bounds for the
  two statistical tests described above:

  \item{TestOnePvalBonferroni:}{p-value for \eqn{H0*} of Test 1.}
  \item{TestTwoPvalBonferroni:}{p-value for \eqn{H0**} of Test 2.}
}

\references{
  Patton, A. and Timmermann, A. (2010):
  Monotonicity in asset returns: New testes with applications to the term structure, the CAPM, and portfolio sorts.
  \emph{Journal of Financial Economics}, \bold{98}, No. 3, p. 605--625.
  \doi{10.1016/0304-4076(89)90094-8}.

  Bonferroni, Carlo E. (1936):
  Teoria statistica delle classi e calcolo delle probabillita.  [Statistical Class Theory and Calculation of Probability]\emph{Pubbl. d. R. Ist. Super. di Sci. Econom. e Commerciali di Firenze}, \bold{8}, p. 1--62.
}

\note{
  The "Bonferroni p-values" are in the sense that we reject the null hypothesis if
  they are less than the size of the test. NOTE of course that unlike usual
  p-valuess these won't be uniformly distributed between \eqn{0} and \eqn{1} under the null hypothesis. In fact, they do not even
  have to lie in [0,1] - they could be lesser than 0 or greater than 1. In such a case, \code{monoBonferroni} returns \code{min(pvalBonferroni, 1)} if \eqn{pvalBonferroni > 1} and \code{max(pvalBonferroni, 0)} if \eqn{pvalBonferroni < 1}.
}

\examples{
## load non-difference return data and calculate the p-value for H0* of Test 1.
data(demo_returns)
tmp <- monoBonferroni(demo_returns, difference = FALSE)
tmp$TestOnePvalBonferroni
}
