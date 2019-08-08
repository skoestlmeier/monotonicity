context('functions')

test_that('monoBonferroni', {
  
  expect_error(monoBonferroni(difference = FALSE))
  expect_error(monoBonferroni(demo_returns, difference = "FALSE"))

  tmp <- monoBonferroni(demo_returns, difference = FALSE)

  expect_equal(tmp$TestOnePvalBonferroni, 1)
  expect_equal(tmp$TestTwoPvalBonferroni, 1)

})
