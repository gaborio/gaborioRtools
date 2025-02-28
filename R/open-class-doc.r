# Modified open_class_doc function with fallbacks
open_class_doc <- function(class_number, render = FALSE) {
  # Check if class_number is valid
  if (!class_number %in% 5:16) {
    stop("Class number must be between 5 to 16")
  }

  # Find package installation path to locate the Rmd files
  pkg_path <- system.file("rmd", package = "gaborioRtools")

  # Check if the directory exists
  if (pkg_path == "") {
    stop("Could not find 'rmd' directory in the package. Make sure your package has an 'inst/rmd/' directory in the source.")
  }

  # Path to Rmd file
  rmd_filename <- paste0("clase", class_number, ".Rmd")
  rmd_file <- file.path(pkg_path, rmd_filename)

  # Path for output HTML
  html_filename <- paste0("clase", class_number, ".html")
  html_file <- file.path(pkg_path, html_filename)

  # Check if HTML exists (minimum requirement)
  if (!file.exists(html_file)) {
    stop(sprintf("Could not find '%s' in %s", html_filename, pkg_path))
  }

  # Check if both Rmd and render flag exist
  can_render <- file.exists(rmd_file) && render

  # Render if needed and possible
  if (can_render) {
    # Check if rmarkdown is available
    if (!requireNamespace("rmarkdown", quietly = TRUE)) {
      warning("Package 'rmarkdown' is required to render the documents. Using existing HTML file.")
      can_render <- FALSE
    } else {
      message(sprintf("Rendering %s...", rmd_filename))
      rmarkdown::render(rmd_file, output_file = html_file, quiet = TRUE)
    }
  } else if (render && !file.exists(rmd_file)) {
    warning("RMD file not found. Using existing HTML file.")
  }

  # Open in browser
  message(sprintf("Opening %s...", html_filename))
  utils::browseURL(html_file)

  # Return invisibly
  invisible(html_file)
}
