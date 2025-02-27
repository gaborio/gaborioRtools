# Create directory structure when package is loaded
.onLoad <- function(libname, pkgname) {
  # Create rmd directory for class documents if it doesn't exist
  pkg_path <- system.file(package = pkgname)
  rmd_dir <- file.path(pkg_path, "rmd")

  if (!dir.exists(rmd_dir)) {
    # In development mode, try to create the directory
    if (file.access(pkg_path, 2) == 0) { # 2 means writable
      dir.create(rmd_dir, recursive = TRUE, showWarnings = FALSE)

      # Look for markdown files in inst/rmd directory (both .Rmd and .md)
      inst_rmd_dir <- file.path(pkg_path, "inst", "rmd")
      if (dir.exists(inst_rmd_dir)) {
        rmd_files <- list.files(inst_rmd_dir, pattern = "\\.(Rmd|md)$", full.names = TRUE)
        if (length(rmd_files) > 0) {
          file.copy(rmd_files, rmd_dir, overwrite = TRUE)
        }
      }

      # Look for markdown files directly in top level package directory
      top_rmd_files <- list.files(pkg_path, pattern = "^clase[0-9]+\\.(Rmd|md)$", full.names = TRUE)
      if (length(top_rmd_files) > 0) {
        file.copy(top_rmd_files, rmd_dir, overwrite = TRUE)
      }
    }
  }
}

# Display startup message when package is attached
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("This is version ", packageVersion(pkgname),
                        " of ", pkgname, ".")
  packageStartupMessage("By Gabriel N. Camargo-Toledo (c)")
  packageStartupMessage("Contains tools for data analysis and materials for teaching R in Quantitative Methods for IR")

  # Check if we should verify system dependencies
  # Only do this when interactive
  if (interactive() && Sys.info()["sysname"] == "Linux") {
    # Use try silently to avoid errors interrupting startup
    try({
      # Check for V8 (either libv8 or libnode)
      v8_check <- try(system("ldconfig -p | grep -E 'libv8|libnode'", intern = TRUE), silent = TRUE)
      has_v8 <- !inherits(v8_check, "try-error") && length(v8_check) > 0

      if (!has_v8) {
        # Try an alternative check with dpkg
        v8_dpkg_check <- try(system("dpkg -l | grep -E 'libv8-dev|libnode-dev'", intern = TRUE), silent = TRUE)
        has_v8 <- !inherits(v8_dpkg_check, "try-error") && length(v8_dpkg_check) > 0
      }

      # Check Magick++
      magick_check <- try(system("ldconfig -p | grep Magick++", intern = TRUE), silent = TRUE)
      has_magick <- !inherits(magick_check, "try-error") && length(magick_check) > 0

      if (!has_magick) {
        # Try an alternative check with dpkg
        magick_dpkg_check <- try(system("dpkg -l | grep -E 'libmagick\\+\\+-dev|graphicsmagick-libmagick-dev-compat'", intern = TRUE), silent = TRUE)
        has_magick <- !inherits(magick_dpkg_check, "try-error") && length(magick_dpkg_check) > 0
      }

      if (!has_v8 || !has_magick) {
        packageStartupMessage("\nSome system dependencies may be missing!")
        packageStartupMessage("Run check_system_deps() for more information.")
      }
    }, silent = TRUE)
  }
}
