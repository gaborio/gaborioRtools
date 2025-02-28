#' Open Class Document
#'
#' This function renders and opens an R Markdown document for a specific class
#' @param class_number Number of the class to open (e.g., 5 for clase5.Rmd)
#' @param render Whether to re-render the document before opening. Default is FALSE
#'
#' @author Gabriel N. Camargo-Toledo \email{gabriel.n.c.t182@@gmail.com}
#' @return Opens the HTML document in a web browser
#' @keywords documentation class teaching
#'
#' @examples
#' open_class_doc(5) # Opens clase5.html
#' open_class_doc(6, render = FALSE) # Opens without re-rendering
#' @importFrom utils browseURL
#' @export

open_class_doc <- function(class_number, render = FALSE) {
  # Check if class_number is valid
  if (!class_number %in% 5:16) {
    stop("Class number must be between 5 to 16")
  }

  # Find package installation path to locate the Rmd files
  pkg_path <- system.file("rmd", package = "gaborioRtools")

  # Check if the directory exists
  if (pkg_path == "") {
    stop("Could not find 'rmd' directory in the package. Make sure it's in inst/rmd/ in your package source.")
  }

  # Path to Rmd file
  rmd_filename <- paste0("clase", class_number, ".Rmd")
  rmd_file <- file.path(pkg_path, rmd_filename)

  # Path for output HTML
  html_filename <- paste0("clase", class_number, ".html")
  html_file <- file.path(pkg_path, html_filename)

  # Check if Rmd file exists
  if (!file.exists(rmd_file)) {
    stop(sprintf("Could not find '%s' in %s", rmd_filename, pkg_path))
  }

  # Render if needed
  if (render || !file.exists(html_file)) {
    # Check if rmarkdown is available
    if (!requireNamespace("rmarkdown", quietly = TRUE)) {
      stop("Package 'rmarkdown' is required to render the documents. Please install it with install.packages('rmarkdown')")
    }
    message(sprintf("Rendering %s...", rmd_filename))
    rmarkdown::render(rmd_file, output_file = html_file, quiet = TRUE)
  }

  # Open in browser
  message(sprintf("Opening %s...", html_filename))
  utils::browseURL(html_file)

  # Return invisibly
  invisible(html_file)
}
