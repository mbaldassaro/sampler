#' Determines sample size by strata using proportional allocation
#' @param df object containing sampling data frame (e.g. data)
#' @param n sample size (integer) or object containing sample size
#' @param strata variable in sampling data frame by which to stratify (e.g. region)
#' @param over (optional) desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)
#' @return Returns proportional sample size per strata (rounded up to nearest integer)
#' @examples
#' ssampcalc(df=albania, n=544, strata=qarku, over=0.05)
#'
#' @examples
#' size <- rsampcalc(nrow(albania), 3, 95, 0.5)
#' ssampcalc(albania, size, qarku)
#' @references
#' [1] Sampling Design & Analysis, S. Lohr, 1999, 4.4
#' @import
#' dplyr
#' @export
ssampcalc <- function(df, n, strata, over=0) {
  if(over !=0) { n <- ceiling(n + n*over) }
  strata <- enquo(strata)
  df %>% group_by(!!strata) %>% summarise(Nh=length(!!strata), wt=t(length(!!strata) / count(df)), nh=t(round(n*((length(!!strata))/count(df)))))
  }
