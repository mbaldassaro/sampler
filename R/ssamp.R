#' Draws stratifed sample without replacement using proportional allocation
#' @param df object containing full sampling data frame (e.g. data)
#' @param n sample size (integer) or object containing sample size
#' @param strata variable in sampling data frame by which to stratify (e.g. region)
#' @param over (optional) desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)
#' @return Returns stratified sample without replacement
#' @examples
#' ssamp(df=albania, n=360, strata=qarku, over=0.1)
#'
#' @examples
#' size <- rsampcalc(nrow(albania), 3, 95, 0.5)
#' stratifiedsample <- ssamp(albania, size, qarku)
#' @import
#' dplyr
#' purrr
#' tidyr
#' @export
ssamp <- function(df, n, strata, over=1) {
  if(over !=1) { n <- ceiling(n + n*over) }
  strata <- enquo(strata)
  samptable <- ssampcalc(df, n, !!strata)
  samptable$nh <- as.integer(samptable$nh)
  df %>% group_by(!!strata) %>% nest_legacy() %>% arrange(!!strata) %>% mutate(nh=samptable$nh) %>% mutate(samp=map2(data, nh, sample_n)) %>% select(!!strata, samp) %>% unnest_legacy()
}


