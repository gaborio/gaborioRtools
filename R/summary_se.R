# TODO: UPDATE to work with tidyverse instead of plyr
## Summarizes data.
## Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
##   data: a data frame.
##   measureVar: the name of a column that contains the variable to be summarized
##   groupVars: a vector containing names of columns that contain grouping variables
##   na.rm: a boolean that indicates whether to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
# BASED ON: https://search.r-project.org/CRAN/refmans/ggiraphExtra/html/summarySE.html
# http://journal.sjdm.org/14/141112a/summarySE.r

#  summary_se --------------------------------------------------------------------
#' Summarizes data
#'
#' Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%)
#' @param data a data frame
#' @param measureVar the name of a column that contains the variable to be summarized
#' @param groupVars a vector containing names of columns that contain grouping variable(s)
#' @param na.rm a boolean that indicates whether to ignore NA's
#' @param renameMean a boolean that indicates if the mean column should be renamed
#'
#' @author Gabriel N. Camargo-Toledo \email{gabriel.n.c.t182@@gmail.com}
#' @return Dataframe of summary statistics usuallly for graphs
#' @keywords microdata metadata analysis summary-statistics
#'
#' @examples
#' TBD
#' @export


summary_se <- function(data = NULL,
                      measureVar,
                      weightsVar = NULL,
                      groupVars=NULL,
                      na.rm=FALSE,
                      conf.interval=.95,
                      .drop=TRUE,
                      renameMean = FALSE) {

  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }

  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  if(is.null(weightsVar)){
    datac <- plyr::ddply(data, groupVars, .drop=.drop,
                         .fun = function(xx, col) {
                           c(N    = length2(xx[[col]], na.rm=na.rm),
                             mean = mean(xx[[col]], na.rm=na.rm),
                             sd   = sd(xx[[col]], na.rm=na.rm))
                         },
                         measureVar)
  } else {
    datac <- plyr::ddply(data, groupVars, .drop=.drop,
                         .fun = function(xx, col) {
                           c(N    = length2(xx[[col]], na.rm=na.rm),
                             mean = Hmisc::wtd.mean(xx[[col]], na.rm=na.rm, weights = xx[[weightsVar]]),
                             sd   = sqrt(Hmisc::wtd.var(xx[[col]], na.rm=na.rm, weights = xx[[weightsVar]]))
                           )
                         },
                         measureVar)
  }


  # Rename the "mean" column
  if (renameMean){
    datac <- plyr::rename(datac, c("mean" = measureVar))
  }


  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean

  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval:
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult

  return(datac)
}
