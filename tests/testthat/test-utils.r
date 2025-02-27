test_that("divide_by_x works correctly", {
  expect_equal(divide_by_x(c(100, 200, 300), 100), c(1, 2, 3))
  expect_equal(divide_by_x(0, 10), 0)
  expect_equal(divide_by_x(5, 2), 2.5)
})

test_that("from_0_to_100 works correctly", {
  # Test with 0-1 range
  test_vec_01 <- c(0, 0.5, 1)
  expect_equal(from_0_to_100(test_vec_01), c(0, 50, 100))
  
  # Test with other range
  test_vec <- c(1, 3, 5)
  expect_equal(from_0_to_100(test_vec), c(0, 50, 100))
})

test_that("not_all_na works correctly", {
  test_vec1 <- c(NA, NA, NA)
  test_vec2 <- c(NA, 1, NA)
  test_vec3 <- c(1, 2, 3)
  
  expect_false(not_all_na(test_vec1))
  expect_true(not_all_na(test_vec2))
  expect_true(not_all_na(test_vec3))
})

test_that("not_any_na works correctly", {
  test_vec1 <- c(NA, NA, NA)
  test_vec2 <- c(NA, 1, NA)
  test_vec3 <- c(1, 2, 3)
  
  expect_false(not_any_na(test_vec1))
  expect_false(not_any_na(test_vec2))
  expect_true(not_any_na(test_vec3))
})

test_that("del_extra_car works correctly", {
  test_str <- 'This is a "test", with br "commas" and brbr line breaks'
  expect_true(is.character(del_extra_car(test_str)))
  
  # Test punctuation removal
  expect_false(grepl('"', del_extra_car(test_str)))
  expect_false(grepl(',', del_extra_car(test_str)))
  
  # Test brbr replacement
  expect_true(grepl('__', del_extra_car('brbr')))
})
