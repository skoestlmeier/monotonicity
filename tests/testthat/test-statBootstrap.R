context('functions')

test_that('statBootstrap', {
  skip_on_cran()
  
  expect_error(statBootstrap(block_length = 10))
  expect_error(statBootstrap(T = "1", block_length = 10))
  expect_error(statBootstrap(T = -1, block_length = 10))
  expect_error(statBootstrap(T = 100, bootstrapRep = "1"))
  expect_error(statBootstrap(T = 100, bootstrapRep  = -1))
  expect_error(statBootstrap(T = 100))
  expect_error(statBootstrap(T = 100, block_length = 7))
  
})
