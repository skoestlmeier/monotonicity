# Contributing to monotonicity

Thanks for taking the time to contribute!

The following is a set of guidelines for contributing to the monotonicity R-package, which is hosted on [CRAN](https://cran.r-project.org/package=monotonicity). These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Code of Conduct

This project and everyone participating in it is governed by the [monotonicity Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [siegfried.koestlmeier@gmail.com](mailto:siegfried.koestlmeier@gmail.com).

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report for monotonicity. Following these guidelines helps to understand your report, reproduce the behavior, and find related reports.

When you are creating a bug report, please include as many details as possible and provide information about your system and R version. Fill out [the required template](/.github/ISSUE_TEMPLATE/bug_report.md), the information it asks for helps to resolve issues faster.

> **Note:** If you miss a feature, please fill out the [feature request](/.github/ISSUE_TEMPLATE/feature_request.md) rather than a bug report.

### Suggesting Enhancements

Feel free to submit an enhancement suggestion for monotonicity, including completely new features and minor improvements to existing functionality. Please describe the desired functionality in detail and provide a source to an academic paper if the feature is based on statistical methods.

Just fill in the [feature request](/.github/ISSUE_TEMPLATE/feature_request.md), including the steps that you imagine you would take if the feature you're requesting existed.


### Pull Requests

* Fill in [the required template](PULL_REQUEST_TEMPLATE.md)
* Do not include issue numbers in the pull request title
* Include screenshots whenever possible.
* Follow the [R styleguid](#R-styleguide) and [CRAN-Policy](#cran-policy).

## Styleguides

### Git Commit Messages

* Use the present tense
* Use the imperative mood
* Limit the first line to 72 characters or less

### R Styleguide

All R code must adhere to [Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml#semicolons).

### CRAN Policy

When contributing to monotonicity, any changes must be conform with the [CRAN-Policy](https://cran.r-project.org/web/packages/policies.html). Please check all contributing code with `R CMD check --as-cran` before commiting to GitHub - no errors or warnings may occur.

