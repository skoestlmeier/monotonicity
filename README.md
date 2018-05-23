# monotonicity

Overview
--------
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/monotonicity)](https://cran.r-project.org/package=monotonicity)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis-CI Build Status](https://travis-ci.org/skoestlmeier/monotonicity.svg?branch=master)](https://travis-ci.org/skoestlmeier/monotonicity)
[![Build status](https://ci.appveyor.com/api/projects/status/nsrpduvdn28gf78r?svg=true)](https://ci.appveyor.com/project/skoestlmeier/monotonicity)
[![codecov](https://codecov.io/gh/skoestlmeier/monotonicity/branch/master/graph/badge.svg)](https://codecov.io/gh/skoestlmeier/monotonicity)
[![Total Downloads](https://cranlogs.r-pkg.org/badges/grand-total/monotonicity?color=blue)](https://CRAN.R-project.org/package=monotonicity)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

`monotonicity` is an R package providing several monotonicity tests for asset returns based on portfolio sorts. It's first version is mainly based on the paper *[Monotonicity in asset returns: New testes with applications to the term structure, the CAPM, and portfolio sorts](https://doi.org/10.1016/0304-4076(89)90094-8)* by Andrew Patton and Allan Timmermann. Please see Andrew Pattons [Matlab code page Nr. 8](https://public.econ.duke.edu/~ap172/code.html) for the original Matlab code or his *[Exec&Share profile](http://www.execandshare.org/CompanionSite/site.do?siteId=56)* providing an online executable version of monotonicity tests.


### Key Features
Functions for monotonicity tests on asset returns based on portfolio sorts:

* Wolak Test
* Up and Down Test
* MR (Monotonic Relationship) Test
* Weak monotonicity test using Bonferroni bounds
* Stationary Bootstrap Simulation

Installation
------------
```r
# The easiest way to install monotonicity is to download via CRAN
install.packages("monotonicity")

# Alternatively, you can install the development version from GitHub
# install.packages("devtools")
devtools::install_github("skoestlmeier/monotonicity")
```
Notes
-----
The monotonicity tests provided by this package are mostly based on simulated bootstrap samples. The results may therefore slightly differ for repeated tests.

For an estimation of the variation of the results, we exemplarily run the MR (Monotonic Relationship) Test provided by the function `monoRelation` 1,000 times with identical input data. We observed the following results for the mean studentised p-value, using the provided R package and in comparison Andrew Pattons original Matlab code:


| Software | Mean | Minimum | Maximum | Standard Deviation
| --- | --- | --- | --- | ---|
| Matlab | 0.032 | 0.014 | 0.047 | 0.0057
| R | 0.031 | 0.018 | 0.048 | 0.0064

In fact, the observed variation seems to be acceptable and should not affect any decision based on the returning p-value, when using the recommended number of 1,000 bootstrap replications.


Contributing
------------
Constributions in form of feedback, comments, code, bug reports or pull requests are most welcome. How to contribute:

* Issues, bug reports, or desired expansions: File a GitHub issue.
* Fork the source code, modify it, and issue a pull request through the project GitHub page.

Please read the [contribution guidelines](CONTRIBUTING.md) on how to contribute to this R-package.

Code of conduct
------------

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
