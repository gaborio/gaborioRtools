# Install Script for gaborioRtools
# Run this script to install gaborioRtools and all required dependencies
# Created by: Gabriel N. Camargo-Toledo
# Modified on: Feb 27, 2025

# Check system type
is_windows <- Sys.info()["sysname"] == "Windows"
is_mac <- Sys.info()["sysname"] == "Darwin"
is_linux <- Sys.info()["sysname"] == "Linux"

# Display system dependency message if needed
if (is_linux) {
  cat("NOTE: Some packages require system libraries to be installed.\n")
  cat("If you encounter errors, you may need to run the following command in the terminal:\n")
  cat("sudo apt-get install libv8-dev libmagick++-dev\n\n")
} else if (is_mac) {
  cat("NOTE: Some packages require system libraries to be installed.\n")
  cat("If you encounter errors, you may need to run the following in the terminal:\n")
  cat("brew install v8 imagemagick\n\n")
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
