test_that("open_class_doc validates input", {
  expect_error(open_class_doc(7), "Class number must be between 5 to 16")
  expect_error(open_class_doc(0), "Class number must be between 5 to 16")
  expect_error(open_class_doc("five"), "Class number must be between 5 to 16")
})

# We can't easily test the actual rendering and opening, but we can test
# that the function returns the expected file path
# This test assumes files would be available in a real installation
test_that("open_class_doc returns correct file path", {
  # Skip test if mockery is not available
  if (!requireNamespace("mockery", quietly = TRUE)) {
    skip("Package 'mockery' not available")
  }

  # Mock the file.exists function to always return TRUE
  mockery::stub(open_class_doc, "file.exists", TRUE)

  # Mock the render function to do nothing
  mockery::stub(open_class_doc, "rmarkdown::render", function(...) NULL)

  # Mock the browseURL function to do nothing
  mockery::stub(open_class_doc, "utils::browseURL", function(...) NULL)

  # Get the package installation path
  pkg_path <- system.file(package = "gaborioRtools")

  # Expected file path
  expected_path <- file.path(pkg_path, "rmd", "clase5.html")

  # Test with render = FALSE
  result <- open_class_doc(5, render = FALSE)
  expect_equal(result, expected_path)
})
