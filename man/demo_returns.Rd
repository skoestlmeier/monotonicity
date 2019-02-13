\name{demo_returns}
\alias{demo_returns}
\title{Asset returns used in Ang, Chen and Xing (RFS, 2006), sorted into ten portfolios.}
\description{
  \code{demo_returns} is a sample of asset returns from July 1963 to December 2001 of all stocks listed on the NYSE and is computed as follows: at the begiinig of each month, tocks are sorted into deciles using estimates of beta based on the past year of daily returns, and value-weighted portfolios are formed. two tests from Wolak (1989, JoE) of inequality constraints in linear econometric models.
}
\usage{
data(demo_returns)
}

\references{
  Patton, A. and Timmermann, A. (2010):
  Monotonicity in asset returns: New testes with applications to the term structure, the CAPM, and portfolio sorts.
  \emph{Journal of Financial Economics}, \bold{98}, No. 3, p. 605--625.
  \doi{10.1016/j.jfineco.2010.06.006}.

  Ang, A., Chen, J. and Xing, Y. (2006):
  Downside Risk. \emph{Review of Financial Studies}, \bold{19}, No. 4, p. 1191--1239.
  \doi{10.1093/rfs/hhj035}.
}

\examples{
## load demo data
data(demo_returns)

## calculate the mean difference return between the top and bottom portfolio
mean(demo_returns[, ncol(demo_returns)] - demo_returns[, 1])
}
