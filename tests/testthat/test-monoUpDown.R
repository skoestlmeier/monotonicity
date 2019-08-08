context('functions')

test_that('monoUpDown', {
  expect_error(monoUpDown(block_length = 10))
  expect_error(monoUpDown(demo_returns, difference = "FALSE"))
  expect_error(monoUpDown(demo_returns, bootstrapRep = "100"))
  expect_error(monoUpDown(demo_returns, bootstrapRep = -1))
  expect_error(monoUpDown(demo_returns))
  expect_error(monoUpDown(demo_returns, block_length = 7))
  expect_error(monoUpDown(demo_returns))
  expect_error(monoUpDown(data = cbind(demo_returns, demo_returns), block_length = 10))
  
  # test for dimension of output
  expect_equal(dim(monoUpDown(demo_returns,block_length = 10)),as.integer(c(4,2)))

  # test that all probability values are within the range [0,1]
  expect_gte(monoUpDown(demo_returns,block_length = 10)[1,1],expected = 0)
  expect_gte(monoUpDown(demo_returns,block_length = 10)[2,1],expected = 0)
  expect_gte(monoUpDown(demo_returns,block_length = 10)[3,1],expected = 0)
  expect_gte(monoUpDown(demo_returns,block_length = 10)[4,1],expected = 0)
  expect_gte(monoUpDown(demo_returns,block_length = 10)[1,2],expected = 0)
  expect_gte(monoUpDown(demo_returns,block_length = 10)[2,2],expected = 0)
  expect_gte(monoUpDown(demo_returns,block_length = 10)[3,2],expected = 0)
  expect_gte(monoUpDown(demo_returns,block_length = 10)[4,2],expected = 0)

  expect_lte(monoUpDown(demo_returns,block_length = 10)[1,1],expected = 1)
  expect_lte(monoUpDown(demo_returns,block_length = 10)[2,1],expected = 1)
  expect_lte(monoUpDown(demo_returns,block_length = 10)[3,1],expected = 1)
  expect_lte(monoUpDown(demo_returns,block_length = 10)[4,1],expected = 1)
  expect_lte(monoUpDown(demo_returns,block_length = 10)[1,2],expected = 1)
  expect_lte(monoUpDown(demo_returns,block_length = 10)[2,2],expected = 1)
  expect_lte(monoUpDown(demo_returns,block_length = 10)[3,2],expected = 1)
  expect_lte(monoUpDown(demo_returns,block_length = 10)[4,2],expected = 1)
})
