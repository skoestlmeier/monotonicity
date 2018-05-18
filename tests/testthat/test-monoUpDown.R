context('functions')

test_that('monoUpDown', {
  expect_equal(dim(monoUpDown(demo_returns,block_length = 10)),as.integer(c(4,2)))
})
