#' Recode to 100 function
#'
#' This function recodes a column to 0-100 creating a new one with _r suffix
#' @param df
#'
#' @author Gabriel N. Camargo-Toledo \email{gabriel.n.c.t182@@gmail.com}
#' @return selects all variables where ALL rows are NA
#' @keywords selecter na
#'
#'
#' @examples
#' cols_values <- list(
#'  EMO_11 = c("5", "6. Positiva"),
#'  PAF_11 = c("5", "6. Honestos"),
#'  PAF_14 = c("5", "6. Solidarios"),
#'  PAF_03 = c("4", "5. De acuerdo"),
#'  PAF_04 = c("4", "5. De acuerdo"),
#'  PAF_08 = c("Smiling", "Very happy")
#' )
#' for (col in names(cols_values)) {
#'     pol_data <- recode_100(pol_data, col, cols_values[[col]])
#' }
#' @export

recode_100 <- function(df, col, values) {
  # Create a new column name by adding "_r" to the original column name
  new_col <- paste0(col, "_r")
  # recode the values to 100 and assign the result to the new column
  df[[new_col]] <- recode(df[[col]], .default = 0, !!!setNames(rep(100, length(values)), values))
  # Return the modified data frame
  return(df)
}
