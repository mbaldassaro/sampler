#' Determines random sample size
#' @param N population universe (e.g. 10000, nrow(df))
#' @param e tolerable margin of error (integer or float, e.g. 5, 2.5)
#' @param ci (optional) confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
#' @param p (optional) anticipated response distribution (defaults to 0.5; takes value between 0 and 1 as input)
#' @param over (optional) desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)
#' @return Returns appropriate sample size (rounded up to nearest integer)
#' @examples
#' rsampcalc(N=5361, e=3, ci=95, p=0.5, over=0.1)
#'
#' @examples
#' rsampcalc(nrow(data), 3)
#' @references
#' [1] Sampling Design & Analysis, S. Lohr, 1999, equation 2.17
#' @export
rsampcalc <- function(N, e, ci=95,p=0.5, over=0) {
  if(ci==80) { z <- 1.28 }
  if(ci==85) { z <- 1.44 }
  if(ci==90) { z <- 1.65 }
  if(ci==95) { z <- 1.96 }
  if(ci==99) { z <- 2.58 }
  if(ci!=99 && ci!=80 && ci!=95 && ci!=90 && ci!=85) { return("Error (Invalid CI): Use 80, 85, 90, 95, or 99") }
  top <- (z^2 * (p*(1-p))) / (e/100)^2
  bottom <- 1 + ((z^2 * (p*(1-p))) / (((e/100)^2) * N))
  n <- ceiling(top/bottom)
  if(over !=0) { n <- ceiling(n + n*over) }
  return(n)
}
