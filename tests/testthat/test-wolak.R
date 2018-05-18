context('functions')

test_that('wolak', {
  tmp <- wolak(demo_returns)

  # test that all probability values are within the range [0,1]
  expect_gte(tmp$TestOnePvalueWolak,expected = 0)
  expect_gte(tmp$TestTwoPvalueWolak,expected = 0)

  expect_lte(tmp$TestOnePvalueWolak,expected = 1)
  expect_lte(tmp$TestTwoPvalueWolak,expected = 1)
})
