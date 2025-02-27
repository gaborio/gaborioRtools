# Install Script for gaborioRtools
# Run this script to install gaborioRtools and all required dependencies
# Created by: Gabriel N. Camargo-Toledo
# Modified on: Feb 27, 2025

# Check system type and dependencies
is_windows <- Sys.info()["sysname"] == "Windows"
is_mac <- Sys.info()["sysname"] == "Darwin"
is_linux <- Sys.info()["sysname"] == "Linux"

# Check system type and dependencies
is_windows <- Sys.info()["sysname"] == "Windows"
is_mac <- Sys.info()["sysname"] == "Darwin"
is_linux <- Sys.info()["sysname"] == "Linux"

# Function to check system dependencies on Linux
check_linux_deps <- function() {
  cat("Checking system dependencies...\n")

  # Check V8
  v8_check <- try(system("ldconfig -p | grep libv8", intern = TRUE), silent = TRUE)
  has_v8 <- !inherits(v8_check, "try-error") && length(v8_check) > 0

  # Check Magick++
  magick_check <- try(system("ldconfig -p | grep Magick++", intern = TRUE), silent = TRUE)
  has_magick <- !inherits(magick_check, "try-error") && length(magick_check) > 0

  if (!has_v8 || !has_magick) {
    cat("Missing system dependencies detected:\n")
    if (!has_v8) cat("  - libv8-dev (required for dagitty)\n")
    if (!has_magick) cat("  - libmagick++-dev (required for summarytools)\n")

    cat("\nYou need to install these dependencies by running this command in your terminal:\n")
    install_cmd <- "sudo apt-get update && sudo apt-get install -y"
    if (!has_v8) install_cmd <- paste(install_cmd, "libv8-dev")
    if (!has_magick) install_cmd <- paste(install_cmd, "libmagick++-dev")
    cat(install_cmd, "\n\n")

    cat("Do you want to continue with the installation anyway? (y/n): ")
    answer <- tolower(readline())

    if (answer != "y" && answer != "yes") {
      cat("\nInstallation aborted. Please install the required dependencies and try again.\n")
      stop("Installation aborted due to missing system dependencies", call. = FALSE)
    }

    cat("\nContinuing installation without all system dependencies.\n")
    cat("Some features may not work until you install the required dependencies.\n\n")
  } else {
    cat("All system dependencies are already installed!\n\n")
  }
}

# Check dependencies based on OS
if (is_linux) {
  check_linux_deps()
} else if (is_mac) {
  cat("NOTE: Some packages require system libraries to be installed.\n")
  cat("If you encounter errors, you may need to run the following in the terminal:\n")
  cat("brew install v8 imagemagick\n\n")
} else if (is_windows) {
  cat("On Windows, dependencies should be handled by binary packages.\n\n")
}

# Core required packages
cat("Installing core required packages from CRAN...\n")
core_packages <- c(
  "tidyverse", "haven", "readxl", "knitr",
  "jtools", "labelled", "showtext", "pastecs",
  "sandwich", "rmarkdown", "devtools", "testthat"
)

# Optional packages that might require extra system dependencies
optional_packages <- c(
  "interactions", "stargazer", "summarytools",
  "nycflights13", "dagitty", "huxtable", "mockery"
)

for (pkg in core_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Installing package:", pkg))
    install.packages(pkg, dependencies = TRUE)
  } else {
    message(paste("Package already installed:", pkg))
  }
}

# Ask about optional packages
cat("\nWould you like to install optional packages? Some may require system dependencies. (y/n): ")
install_optional <- tolower(readline())

if (install_optional == "y" || install_optional == "yes") {
  cat("\nInstalling optional packages...\n")
  for (pkg in optional_packages) {
    tryCatch({
      if (!requireNamespace(pkg, quietly = TRUE)) {
        message(paste("Installing package:", pkg))
        install.packages(pkg, dependencies = TRUE)
      } else {
        message(paste("Package already installed:", pkg))
      }
    }, error = function(e) {
      message(paste("Error installing", pkg, ": This package may require system dependencies."))
    })
  }
}

# Install gaborioRtools from GitHub
cat("\nInstalling gaborioRtools from GitHub...\n")
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
devtools::install_github("gaborio/gaborioRtools")

# Verify installation
cat("\nVerifying installation...\n")
if (requireNamespace("gaborioRtools", quietly = TRUE)) {
  cat("gaborioRtools successfully installed!\n")
  cat("You can now load the package with: library(gaborioRtools)\n")
  cat("To open class documents, use: open_class_doc(5) or open_class_doc(6)\n")
} else {
  cat("Installation failed. Please check the error messages above.\n")
}
