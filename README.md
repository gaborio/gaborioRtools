
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gaborioRtools

<!-- badges: start -->
<!-- badges: end -->

This is my personal package with a bunch of useful functions …

## Installation

You can install the development version of gaborioRtools from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("gaborio/gaborioRtools")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(gaborioRtools)
#> Loading required package: tidyverse
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.2     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.0
#> ✔ ggplot2   3.4.2     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.1     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
#> Loading required package: labelled
#> 
#> Loading required package: showtext
#> 
#> Loading required package: sysfonts
#> 
#> Loading required package: showtextdb
## basic recode_100 function
# TODO: include data to package so example works
# cols_values <- list(
#   EMO_11 = c("5", "6. Positiva"),
#   PAF_11 = c("5", "6. Honestos"),
#   PAF_14 = c("5", "6. Solidarios"),
#   PAF_03 = c("4", "5. De acuerdo"),
#   PAF_04 = c("4", "5. De acuerdo"),
#   PAF_08 = c("Smiling", "Very happy")
#   )
# for (col in names(cols_values)) {
#   pol_data <- recode_100(pol_data, col, cols_values[[col]])
#   }
```
