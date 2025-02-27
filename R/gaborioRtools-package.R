#' gaborioRTools: Personal R package for data analysis and teaching
#'
#' @description
#' This package has functions for data manipulation, cleaning, and analysis.
#' It also contains educational materials for teaching R programming in
#' quantitative methods courses for International Relations at Javeriana University.
#'
#' @section Data Management Functions:
#' \itemize{
#'   \item \code{\link{divide_by_x}}: Divide a vector by a specific value
#'   \item \code{\link{recode_100}}: Recode values to 0-100 scale
#'   \item \code{\link{from_0_to_100}}: Rescale a vector to 0-100 range
#'   \item \code{\link{not_all_na}}: Helper to select columns that aren't all NA
#'   \item \code{\link{not_any_na}}: Helper to select columns without any NA
#'   \item \code{\link{del_extra_car}}: Remove extra characters from strings
#'   \item \code{\link{select_cols}}: Select columns for export
#' }
#'
#' @section Data Analysis Functions:
#' \itemize{
#'   \item \code{\link{summary_se}}: Summarize data with standard errors
#' }
#'
#' @section Teaching Materials:
#' \itemize{
#'   \item \code{\link{open_class_doc}}: Open class documents in HTML format
#' }
#'
#' @source \url{https://github.com/gaborio/gaborioRtools}
#'
#' @import tidyverse
#' @import labelled
#' @import jtools
#' @importFrom splitstackshape cSplit
#' @importFrom showtext showtext_auto
#'
#' @name gaborioRtools
#' @aliases _PACKAGE
NULL
#> NULL
