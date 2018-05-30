#' Determines sample size by strata using sub-units
#' @param df object containing full sampling data frame (e.g. data)
#' @param n sample size (integer) or object containing sample size
#' @param strata variable in sampling data frame by which to stratify (e.g. region)
#' @param unit variable in sampling data frame containing sub-units (e.g. population)
#' @param over (optional) desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)
#' @return Returns sample size per strata based on sub-units (rounded up to nearest integer)
#' @references
#' [1] Sampling Design & Analysis, S. Lohr, 1999, 4.4
#' @import
#' dplyr
#' @export
psampcalc <- function(df, n, strata, unit, over=0) {
  if(over !=0) { n <- ceiling(n + n*over) }
  strata <- enquo(strata)
  unit <- enquo(unit)
  df %>% group_by(!!strata) %>% summarise(Nh=length(!!strata), wt=(length(!!strata) / count(df)), pNh=sum(!!unit)) %>% mutate(pwt=pNh/sum(pNh), nh=ceiling(n*pwt))
}
