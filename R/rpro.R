#' Calculate proportion and margin of error (simple random sample)
#' @param df object containing data frame on which to perform analysis (e.g. data)
#' @param col_name variable in data frame for which you want to calculate proportion and margin of error
#' @param ci (optional) confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
#' @param na (optional) value that you want to filter and exclude (defaults to include everything)
#' @param N (optional) population universe (e.g. 10000, nrow(df)); if N value is passed as an argument, margin of error will be calculated using fpc
#' @return Returns table of responses (n), proportions, margins of error, lower and upper bounds by factor for a given variable
#' @examples
#' rpro(df=opening, col_name=openTime, ci=95, na="n/a", N=5361)
#' @references
#' [1] Sampling Design & Analysis, S. Lohr, 1999, Equation 2.15
#' @import
#' dplyr
#' @export
rpro <- function(df,col_name, ci=95, na="", N=0) {
  col_name <- enquo(col_name)
  if(ci==80) { z <- 1.28 }
  if(ci==85) { z <- 1.44 }
  if(ci==90) { z <- 1.65 }
  if(ci==95) { z <- 1.96 }
  if(ci==99) { z <- 2.58 }
  if(ci!=99 && ci!=80 && ci!=95 && ci!=90 && ci!=85) { return("Error (Invalid CI): Use 80, 85, 90, 95, or 99") }
  if(N==0) {table <- df %>% dplyr::select(!!col_name) %>% filter(!!col_name != na) %>% count(!!col_name) %>% mutate(midpoint=n/sum(n), se=sqrt(midpoint*(1-midpoint)/(sum(n)-1)), ci=se*z, lower=midpoint-ci, upper=midpoint+ci) %>% transmute(!!col_name, n=n, midpoint=midpoint*100, me=ci*100, lower=lower*100, upper=upper*100)}
  if(N > 0) {table <- df %>% dplyr::select(!!col_name) %>% filter(!!col_name != na) %>% count(!!col_name) %>% mutate(midpoint=n/sum(n), fpc=(N-sum(n)) / (N-1), se=sqrt(fpc * (midpoint*(1-midpoint)/(sum(n)))), ci=se*z, lower=midpoint-ci, upper=midpoint+ci) %>% transmute(!!col_name, n=n, midpoint=midpoint*100, me=ci*100, lower=lower*100, upper=upper*100)}
  return(table)
  }
