# monotonicity 1.3.1

The R version 4.0.0 sets `_R_CLASS_MATRIX_ARRAY_=true`, so matrix objects now also inherit from class `array`. As a consequence,
the testthat unit tests had to be slightly adjusted.

# monotonicity 1.3

* Added the option to allow a user-specific treshold value for checking non-linear optimization results against zero. Resulting values are close to zero, but due to the internal used machine precision, checking against zero would be wrong. The default treshold value is 1e-6 and solution values smaller than the treshold are treated as being zero. 

* Added `testthat` test-cases for further development.

* Bug fix in Wolak's test: Corrected p-values for both test statistics.

# monotonicity 1.2
## New features

* Minor bug-fixes in documentation and references.

# monotonicity 1.1
## New features

* `testthat` for unit testing.

* `AppVeyor` for additional build tests on Microsoft Windows platforms.

* `CODE_OF_CONDUCT`, `PULL_REQUEST_TEMPLATE` and `ISSUE_TEMPLATE` for contribution to the project.

* Bug fix in `monoSummary`: Output results are now in number-format rather than a sequence of characters.

# monotonicity 1.0
## New features

* `wolak` implements two tests from Wolak (1989, JoE) of inequality constraints in linear econometric models.

* `statBootstrap` implements the stationary bootstrap method from Politis & Romano (1994, JASA). 

* `monoUpDown` implements the 'Up and Down' tests from Patton and Timmermann (2010, JFE).

* `monoSummary` implements the whole test for monotonicity in asset returns, based on portfolio sorts, in (JoE, 2010).

* `monoRelation` implements the 'monotonic relationship' tests from Patton and Timmermann (2010, JFE).

* `monoBonferroni` implements the test of weak monotonicity using Bonferroni bounds described in Patton and Timmermann (2010, JFE)

## References
  Wolak, Frank A. (1989):
  Testing Inequality Constraints in Linear Econometric Models.
  *Journal of Econometrics*, **41**, p. 205-235.
  doi: [10.1016/0304-4076(89)90094-8](https://doi.org/10.1016/0304-4076(89)90094-8).
  
   Patton, A. and Timmermann, A. (2010):
  Monotonicity in asset returns: New testes with applications to the term structure, the CAPM, and portfolio sorts.
  *Journal of Financial Economics*, **98**, No. 3, p. 605-625.
  doi: [10.1016/j.jfineco.2010.06.006](https://doi.org/10.1016/j.jfineco.2010.06.006).
  
  Politis, Dimitris N. & Romano, Joseph P. (1994): The Stationary Bootstrap.
  *Journal of The American Statistical Association*,
  **89**, No. 428, p. 1303-1313. doi: [10.1080/01621459.1994.10476870](https://doi.org/10.1080/01621459.1994.10476870).
