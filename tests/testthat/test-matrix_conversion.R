context('functions')

test_that('matrix_conversion', {
  
  library(xts)
  
  test_matrix <- matrix(c(1,2,3,4), ncol = 2)
  test_df <- data.frame(c(1,2,3,4), ncol = 2)
  
  test_ts <- ts(1:24, frequency = 12, start = c(1990, 1))
  test_xts <- as.xts(test_ts)
  test_zoo <- as.zoo(test_ts)
  
  expect_type(matrix_conversion(test_matrix), "double")
  expect_type(matrix_conversion(test_df), "double")
  
  expect_equal(class(matrix_conversion(test_matrix)), "matrix")
  expect_equal(class(matrix_conversion(test_df)), "matrix")
  expect_equal(class(matrix_conversion(test_ts)), "ts")
  expect_equal(class(matrix_conversion(test_xts)), c("xts", "zoo"))
  expect_equal(class(matrix_conversion(test_zoo)), c("zooreg", "zoo"))
  
})