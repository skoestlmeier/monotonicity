\name{statBootstrap}
\alias{statBootstrap}
\title{Stationary bootstrap method}
\description{
  \code{statBootstrap} implements the stationary bootstrap method from Politis & Romano (1994, JASA). This function generates bootstrap samples of the matrix data and returns the time indices for each sample.
}
\usage{
statBootstrap(T, bootstrapRep = 1000, block_length)
}
\arguments{
  \item{T}{A scalar, the number of time series observations to generate.}

  \item{bootstrapRep}{A numeric scalar: the number of used bootstrap samples.}

  \item{block_length}{A numeric scalar: The average length of the block to usefor the stationary bootstrap. This parameter is related to how much serial correlation is in your data. Use 10/6/3/2 as the block length if data is measured in daily/monthly/quarterly/annual returns.}
}

\value{
  \code{statBootstrap} returns an object of \code{\link{class}} \code{"matrix"}:

  \item{\code{"matrix"}:}{A "T x bootstrapRep" matrix of time indices for each bootstrap sample.}
}

\references{
Politis, Dimitris N. & Romano, Joseph P. (1994): The Stationary Bootstrap. \emph{Journal of The American Statistical Association},
  \bold{89}, No. 428, p. 1303--1313. \doi{10.1080/01621459.1994.10476870}.
}

\examples{

## Assuming daily return data for 100 time series observations.
## The returning matrix for default settings contains 1,000 bootstrap samples.
bootstrap_sample <- statBootstrap(T = 100, block_length = 10)

## 200 bootstrap samples using monthly return data with 250 time series observations.
bootstrap_sample <- statBootstrap(T = 250, bootstrapRep = 200, block_length = 6)
}
