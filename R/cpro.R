#' Calculate proportion and margin of error (unequal-sized cluster sample)
#' @param df object containing data frame on which to perform analysis
#' @param numerator variable in data frame for which you want to calculate proportion and margin of error
#' @param denominator variable in data frame containing population sizes of unequal clusters
#' @param ci (optional) confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
#' @param na (optional) value that you want to filter and exclude (defaults to include everything)
#' @param N (optional) population universe (e.g. 10000, nrow(df)); if N value is passed as an argument, margin of error will be calculated using fpc
#' @return Returns table of responses (n), proportions, margins of error, lower and upper bounds by factor for a given variable in a stratified sample
#' @examples
#' alresults <- ssamp(albania, 890, qarku)
#' cpro(df=alresults, numerator=totalVoters, denominator=zgjedhes, ci=95)
#' cpro(df=alresults, numerator=pd, denominator=validVotes, ci=95, N=5361)
#' @references
#' [1] Survey Sampling, L. Kish, 1965, Equation 6.3.4
#' [2] Sampling Techniques, W.G. Cochran, 1977, Equation 3.34
#' @import
#' dplyr
#' @export
cpro <- function(df, numerator, denominator, ci=95, na="", N=0) {
  numerator <- enquo(numerator)
  denominator <- enquo(denominator)
  if(ci==80) { z <- 1.28 }
  if(ci==85) { z <- 1.44 }
  if(ci==90) { z <- 1.65 }
  if(ci==95) { z <- 1.96 }
  if(ci==99) { z <- 2.58 }
  if(N > 0) { results <- df %>% dplyr::select(!!numerator, !!denominator) %>% filter(!!numerator != na & !!denominator != na) %>% mutate(third=(!!numerator - (sum(!!numerator)/sum(!!denominator)) * !!denominator)^2) %>% summarise(third=sum(third), p=sum(!!numerator)/sum(!!denominator), x2=sum(!!denominator)^2, n=nrow(df), nminus1=n-1, oneminusf=1-(n/N), first=oneminusf/x2, second=n/nminus1) %>% transmute(n=n, midpoint=p*100, me=z*(sqrt(first*second*third))*100, lower=midpoint-me, upper=midpoint+me) }
  if(N==0)  { results <- df %>% dplyr::select(!!numerator, !!denominator) %>% filter(!!numerator != na & !!denominator != na) %>% mutate(aipmi2=(!!numerator - (sum(!!numerator)/sum(!!denominator)) * !!denominator)^2) %>% summarise(aipmi2=sum(aipmi2), p=sum(!!numerator)/sum(!!denominator), m2=mean(!!denominator)^2, n=nrow(df), nnminus1m2=m2*(n*(n-1))) %>% transmute(n=n, midpoint=p*100, me=z*(sqrt(aipmi2/nnminus1m2))*100, lower=midpoint-me, upper=midpoint+me) }
  return(results)
}
