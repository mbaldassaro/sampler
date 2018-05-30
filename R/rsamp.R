#' Draws simple random sample without replacement
#' @param df object containing full sampling data frame (e.g. data)
#' @param n sample size (integer) or object containing sample size
#' @param over (optional) desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)
#' @param rep (optional)
#' @return Returns simple random sample without replacement
#' @examples
#' rsamp(albania, n=360, over=0.1, rep=FALSE)
#'
#' @examples
#' size <- rsampcalc(nrow(albania), 3, 95, 0.5)
#' randomsample <- rsamp(albania, size)
#' @references
#' Simplified wrapper around dplyr::sample_n()
#' @import
#' dplyr
#' @export
rsamp <- function(df, n, over=0, rep=FALSE) {
  if(over !=0) { n <- ceiling(n + n*over) }
  if(rep == TRUE) {rep <- TRUE}
  sample_n(df, n, rep)
}
