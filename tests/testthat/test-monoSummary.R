context('functions')

test_that('monoSummary', {
  skip_on_cran()
  
  expect_error(monoSummary(block_length = 10))
  expect_error(monoSummary(demo_returns, bootstrapRep = "100", block_length = 10))
  expect_error(monoSummary(demo_returns, bootstrapRep = -1, block_length = 10))
  expect_error(monoSummary(demo_returns, wolakRep = "100", block_length = 10))
  expect_error(monoSummary(demo_returns, wolakRep = -1, block_length = 10))
  expect_error(monoSummary(demo_returns, block_length = 10, difference = "FALSE"))
  expect_error(monoSummary(demo_returns, block_length = 10, increasing = "FALSE"))
  expect_error(monoSummary(demo_returns, block_length = 10, plot = "FALSE"))
  expect_error(monoSummary(demo_returns))
  expect_error(monoSummary(demo_returns, block_length = 7))
  expect_error(monoSummary(cbind(demo_returns, demo_returns), block_length = 10))
  
  tmp <- suppressWarnings(monoSummary(demo_returns, bootstrapRep = 1, wolakRep = 1, block_length = 10))

  # test for dimension of output
  expect_equal(dim(tmp),as.integer(c(1,9)))

  # test that all probability values are within the range [0,1]
  expect_gte(tmp[1,1], expected = 0)
  expect_gte(tmp[1,2], expected = 0)
  expect_gte(tmp[1,3], expected = 0)
  expect_gte(tmp[1,4], expected = 0)
  expect_gte(tmp[1,5], expected = 0)
  expect_gte(tmp[1,6], expected = 0)
  expect_gte(tmp[1,7], expected = 0)
  expect_gte(tmp[1,8], expected = 0)
  expect_gte(tmp[1,9], expected = 0)

  expect_lte(tmp[1,1], expected = 1)
  expect_lte(tmp[1,2], expected = 1)
  expect_lte(tmp[1,3], expected = 1)
  expect_lte(tmp[1,4], expected = 1)
  expect_lte(tmp[1,5], expected = 1)
  expect_lte(tmp[1,6], expected = 1)
  expect_lte(tmp[1,7], expected = 1)
  expect_lte(tmp[1,8], expected = 1)
  expect_lte(tmp[1,9], expected = 1)
})
