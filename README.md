# monotonicity

Overview
--------
[![Travis-CI Build Status](https://travis-ci.org/skoestlmeier/monotonicity.svg?branch=master)](https://travis-ci.org/skoestlmeier/monotonicity)

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

License
-------
BSD 3-clause license.
