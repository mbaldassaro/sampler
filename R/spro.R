#' Calculate proportion and margin of error (stratified sample)
#' @param fulldf object containing original data frame used to draw sample
#' @param sampdf object containing data frame on which to perform analysis
#' @param strata variable in both data frames by which to stratify
#' @param col_name variable in data frame for which you want to calculate proportion and margin of error
#' @param ci (optional) confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
#' @param na (optional) value that you want to filter and exclude (defaults to include everything)
#' @return Returns table of responses (n), proportions, margins of error, lower and upper bounds by factor for a given variable in a stratified sample
#' @examples
#' spro(fulldf=albania, sampdf=opening, strata=qarku, col_name=openTime, ci=95, na="n/a")
#' @references
#' [1] Sampling Design & Analysis, S. Lohr, 1999, 4.6 & 4.7
#' @import
#' dplyr
#' @importFrom tidyr spread
#'
#' @importFrom reshape melt
#' @export
spro <- function(fulldf, sampdf, strata, col_name, ci=95, na="") {
  strata <- enquo(strata)
  col_name <- enquo(col_name)
  stratax <- quo_name(enquo(strata))
  col_namex <- quo_name(enquo(col_name))
  if(ci==80) { z <- 1.28 }
  if(ci==85) { z <- 1.44 }
  if(ci==90) { z <- 1.65 }
  if(ci==95) { z <- 1.96 }
  if(ci==99) { z <- 2.58 }
  if(ci!=99 && ci!=80 && ci!=95 && ci!=90 && ci!=85) { return("Error (Invalid CI): Use 80, 85, 90, 95, or 99") }
  a1 <- fulldf %>% group_by(!!strata) %>% summarise(Nh=length(!!strata), wt=(length(!!strata) / count(sampdf))) %>% transmute(!!strata, Nh)
  b1 <- sampdf %>% group_by(!!strata) %>% filter(!!col_name != na) %>% count(!!strata)
  b2 <- sampdf %>% group_by(!!strata) %>% select(!!strata, !!col_name) %>% filter(!!col_name != na) %>% count(!!col_name) %>% mutate(midpointnh=n/sum(n)) %>% transmute(!!col_name,midpointnh)
  bn <- sampdf %>% group_by(!!col_name) %>% filter(!!col_name != na) %>% count(!!col_name) %>% summarise(n)
  b3 <- spread(b2, key=!!col_name, value=midpointnh)
  b4 <- merge(b3,a1,by=stratax)
  b5 <- merge(b4,b1,by=stratax)
  bt <- b5 %>% mutate(NhN=Nh/sum(Nh))
  b6 <- melt(bt,id=c(stratax, "n","Nh","NhN"))
  bu <- b6 %>% mutate(midpoint=value*NhN, variance=value*(1-value)/(n-1))
  b8 <- bu %>% group_by(!!strata, midpoint, variable, n, Nh, NhN) %>% filter(midpoint!= na && variance != na) %>% summarise(midpointstr=sum(midpoint), varstr=sum(variance))
  b9 <- b8 %>% mutate(first=1-(n/Nh), second=NhN^2, svar=first*second*varstr)
  b10 <- b9 %>% group_by(variable) %>% summarise(midstr=sum(midpointstr), sumsvar=sum(svar))
  b11 <- b10 %>% transmute(variable=variable, midpoint=midstr*100, me=z*(sqrt(sumsvar)*100),lower=midpoint-me,upper=midpoint+me)
  b12 <- cbind(bn,b11[,-1])
  print(b12)
}
