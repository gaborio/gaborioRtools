test_that("recode_100 creates new column correctly", {
  # Create a test dataframe
  test_df <- data.frame(
    test_col = c("1", "2", "3", "4", "5"),
    stringsAsFactors = FALSE
  )
  
  # Run the function - recode 5 to 100
  result_df <- recode_100(test_df, "test_col", c("5"))
  
  # Check that the new column exists
  expect_true("test_col_r" %in% names(result_df))
  
  # Check that the values are recoded correctly
  expect_equal(result_df$test_col_r, c(0, 0, 0, 0, 100))
  
  # Test with multiple values to recode
  result_df2 <- recode_100(test_df, "test_col", c("4", "5"))
  expect_equal(result_df2$test_col_r, c(0, 0, 0, 100, 100))
})
