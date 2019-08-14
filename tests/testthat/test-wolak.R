context('functions')

test_that('wolak', {
  skip_on_cran()
  
  expect_error(wolak())
  expect_error(wolak(data = 1))
  expect_error(wolak(demo_returns, wolakRep = "100"))
  expect_error(wolak(demo_returns, wolakRep = -1))
  expect_error(wolak(demo_returns, wolakRep = 100, increasing = "FALSE"))
  expect_error(wolak(demo_returns, wolakRep = 100, difference = "FALSE"))
  expect_error(wolak(T = 100))
  expect_error(wolak(T = 100, block_length = 7))
  expect_error(wolak(demo_returns, zero_treshold = "0.1"))
  
  tmp <- wolak(demo_returns)

  expect_gte(tmp$TestOnePvalueWolak, expected = 0.89)
  expect_gte(tmp$TestTwoPvalueWolak, expected = 0.74)

  expect_lte(tmp$TestOnePvalueWolak, expected = 0.96)
  expect_lte(tmp$TestTwoPvalueWolak, expected = 0.81)

  # test that all probability values are within the range [0,1]
  expect_gte(tmp$TestOnePvalueWolak,expected = 0)
  expect_gte(tmp$TestTwoPvalueWolak,expected = 0)

  expect_lte(tmp$TestOnePvalueWolak,expected = 1)
  expect_lte(tmp$TestTwoPvalueWolak,expected = 1)
})
