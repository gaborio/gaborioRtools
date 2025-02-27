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

  # List of dependencies to check with alternative package names
  deps <- list(
    v8 = list(
      check_cmd = "ldconfig -p | grep -E 'libv8|libnode'",
      alt_check_cmds = c(
        "dpkg -l | grep -E 'libv8-dev|libnode-dev'"
      ),
      apt_pkgs = c("libv8-dev", "libnode-dev")
    ),
    magick = list(
      check_cmd = "ldconfig -p | grep Magick++",
      alt_check_cmds = c(
        "dpkg -l | grep -E 'libmagick\\+\\+-dev|graphicsmagick-libmagick-dev-compat'"
      ),
      apt_pkgs = c("libmagick++-dev", "graphicsmagick-libmagick-dev-compat")
    )
  )

  # Check which dependencies are missing
  missing_deps <- list()
  for (dep_name in names(deps)) {
    dep <- deps[[dep_name]]
    if (!quiet) message("Checking for system dependency: ", dep_name)

    # Try primary check command
    check_result <- try(system(dep$check_cmd, intern = TRUE), silent = TRUE)
    found <- !inherits(check_result, "try-error") && length(check_result) > 0

    # If primary check fails, try alternative checks
    if (!found && !is.null(dep$alt_check_cmds)) {
      for (alt_cmd in dep$alt_check_cmds) {
        alt_result <- try(system(alt_cmd, intern = TRUE), silent = TRUE)
        if (!inherits(alt_result, "try-error") && length(alt_result) > 0) {
          found <- TRUE
          break
        }
      }
    }

    if (!found) {
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
    message("\nThe following system dependencies are missing:")

    # For each missing dependency
    for (dep_name in names(missing_deps)) {
      dep <- missing_deps[[dep_name]]
      message(paste0(" - ", dep_name, " (install one of: ", paste(dep$apt_pkgs, collapse = ", "), ")"))
    }

    # Collect all package options
    all_pkg_options <- unlist(lapply(missing_deps, function(dep) dep$apt_pkgs))
    first_options <- sapply(missing_deps, function(dep) dep$apt_pkgs[1])

    message("\nTo install dependencies, run one of these commands in your terminal:")

    # Option 1: Try the first package for each dependency
    message("\nOption 1 (most common packages):")
    message("sudo apt-get update && sudo apt-get install -y ", paste(first_options, collapse = " "))

    # Option 2: Alternative packages if option 1 doesn't work
    if (length(all_pkg_options) > length(first_options)) {
      message("\nOption 2 (if Option 1 doesn't work):")
      message("sudo apt-get update && sudo apt-get install -y ", paste(all_pkg_options, collapse = " "))
    }

    message("\nAfter installing the dependencies, restart R and try again.")
    message("Note: On your system, it appears 'libnode-dev' may be the correct package for V8.")
  }

  return(FALSE)
}
