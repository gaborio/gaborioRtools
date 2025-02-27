#' Check system dependencies
#'
#' This function checks if required system libraries are installed
#' and provides instructions for installing missing dependencies (Linux only).
#'
#' @param quiet Logical; if TRUE, suppress messages
#' @return Logical value indicating if all dependencies are available
#' @export
#'
#' @examples
#' \dontrun{
#' check_system_deps()
#' }
check_system_deps <- function(quiet = FALSE) {
  # Only run on Linux
  if (Sys.info()["sysname"] != "Linux") {
    if (!quiet) {
      message("System dependency check only runs on Linux.")
      if (Sys.info()["sysname"] == "Darwin") {
        message("On macOS, install dependencies with: brew install v8 imagemagick")
      } else if (Sys.info()["sysname"] == "Windows") {
        message("On Windows, dependencies should be handled by binary packages.")
      }
    }
    return(TRUE)
  }

  # List of dependencies to check
  deps <- list(
    v8 = list(
      check_cmd = "ldconfig -p | grep libv8",
      apt_pkg = "libv8-dev"
    ),
    magick = list(
      check_cmd = "ldconfig -p | grep Magick++",
      apt_pkg = "libmagick++-dev"
    )
  )

  # Check which dependencies are missing
  missing_deps <- list()
  for (dep_name in names(deps)) {
    dep <- deps[[dep_name]]
    if (!quiet) message("Checking for system dependency: ", dep_name)

    # Run the check command
    check_result <- try(system(dep$check_cmd, intern = TRUE), silent = TRUE)

    # If check failed or returned nothing, the dependency is missing
    if (inherits(check_result, "try-error") || length(check_result) == 0) {
      missing_deps[[dep_name]] <- dep
      if (!quiet) message("  - Missing: ", dep_name)
    } else {
      if (!quiet) message("  - Found: ", dep_name)
    }
  }

  # If no dependencies are missing, return
  if (length(missing_deps) == 0) {
    if (!quiet) message("All system dependencies found.")
    return(TRUE)
  }

  # We found missing dependencies - provide instructions
  if (!quiet) {
    apt_pkgs <- sapply(missing_deps, function(dep) dep$apt_pkg)
    message("\nThe following system dependencies are missing:")
    message(paste(" -", apt_pkgs, collapse = "\n"))

    message("\nTo install them, run the following command in your terminal:")
    message("sudo apt update && sudo apt install -y ", paste(apt_pkgs, collapse = " "))

    message("\nAfter installing the dependencies, restart R and try again.")
  }

  return(FALSE)
}
