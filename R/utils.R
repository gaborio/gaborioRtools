#' Divide by x
#'
#' This function divides any vector by a given X, we use it regularly to include in pipes.
#' @param vec vector to divide by x
#' @param x value to divide the vector by
#'
#' @author Gabriel N. Camargo-Toledo \email{gabriel.n.c.t182@@gmail.com}
#' @return vector divided by x
#' @keywords divide hundreds percentage proportion
#'
#'
#' @examples
#' divide_by_x(data$percentage, 100) # This creates proportion from percentage
#' @export

divide_by_x <- function(vec, x) {
  r <- vec/x
  r
}


#' Selecter for columns that are ALL NA
#'
#' This a selection helper is used normally inside a select call to drop variables that are all NA
#' @param df
#'
#' @author Gabriel N. Camargo-Toledo \email{gabriel.n.c.t182@@gmail.com}
#' @return selects all variables where ALL rows are NA
#' @keywords selecter na
#'
#'
#' @examples
#' select(where(not_all_na))
#' @export

not_all_na <- function(x) any(!is.na(x))

#' Selecter for columns that have ANY NA
#'
#' This a selection helper is used normally inside a select call to drop variables that are all NA
#' @param df
#'
#' @author Gabriel N. Camargo-Toledo \email{gabriel.n.c.t182@@gmail.com}
#' @return selects all variables where ALL rows are NA
#' @keywords   selecter na
#'
#'
#' @examples
#' select(where(not_any_na))
#' @export


not_any_na <- function(x) all(!is.na(x))


#' Function to rescale a vector to 0-100 scale
#'
#' This function takes any vector and rescales it in a linear way so that the new range is 0 to 100. Useful specially when creating indicators
#' @param x numeric vector to rescale to 0-100
#'
#' @author Gabriel N. Camargo-Toledo \email{gabriel.n.c.t182@@gmail.com}
#' @return numeric vector in a 0-100 scale
#' @keywords rescale indicators
#'
#'
#' @examples
#' x <- c(1,2,3,1,3,2,4,5,4,3,2,5,4,3,2,1,4,5)
#' from_0_to_100(x)
#' @export


from_0_to_100 <- function(x){
  if(max(x, na.rm = T) == 1 && min(x, na.rm = T) == 0){
    o = x*100
  } else {
    o = (1-((max(x, na.rm = T)-x)/(max(x, na.rm = T)-1)))*100
  }
  o
}

#' Function to eliminate extra characters
#'
#' This function eliminates extra characters. For now it only eliminates some common extra characters
#' @param x character vector
#'
#' @author Gabriel N. Camargo-Toledo \email{gabriel.n.c.t182@gmail.com}
#' @return character vector without extra characters
#' @keywords clean characters
#'
#'
#' @examples
#' del_extra_car(cjData$conjoint.0.options)
#' @export


del_extra_car <- function(x) {
  o <- x |>
    str_replace_all('","', "     ") |>
    str_replace_all("[[:punct:]]", "") |>
    str_replace_all("brbrbrbr", "__") |>
    str_replace_all("brbrbr", "__") |>
    str_replace_all("brbr", "__") |>
    str_replace_all("     ", " / ")
  o
}

