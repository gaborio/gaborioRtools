# Create directory structure when package is loaded
.onLoad <- function(libname, pkgname) {
  # Create rmd directory for class documents if it doesn't exist
  pkg_path <- system.file(package = pkgname)
  rmd_dir <- file.path(pkg_path, "rmd")
  
  if (!dir.exists(rmd_dir)) {
    # In development mode, try to create the directory
    if (file.access(pkg_path, 2) == 0) { # 2 means writable
      dir.create(rmd_dir, recursive = TRUE, showWarnings = FALSE)
      
      # Copy the Rmd files from inst/rmd to the package directory
      inst_rmd_dir <- system.file("inst", "rmd", package = pkgname)
      if (dir.exists(inst_rmd_dir)) {
        rmd_files <- list.files(inst_rmd_dir, pattern = "\\.Rmd$", full.names = TRUE)
        if (length(rmd_files) > 0) {
          file.copy(rmd_files, rmd_dir, overwrite = TRUE)
        }
      }
    }
  }
  
  # Do not show startup messages here - use .onAttach for that
}

# Display startup message when package is attached
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("This is version ", packageVersion(pkgname),
                        " of ", pkgname, ".")
  packageStartupMessage("By Gabriel N. Camargo-Toledo (c)")
  packageStartupMessage("Contains tools for data analysis and materials for teaching R")
}
