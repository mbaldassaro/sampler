#' Identifies number of missing points by strata between sample and collected data
#' @param sampdf object containing data frame of sample points
#' @param colldf object containing data frame of collected data
#' @param strata variable in both data frames by which to stratify
#' @param col_name common variable (i.e. key) in data frames by which to check for missing points
#' @return Returns table of number of sample points by strata missing from collected data
#' @examples
#' alsample <- rsamp(df=albania, 544)
#' alreceived <- rsamp(df=alsample, 390)
#' smissing(sampdf=alsample, colldf=alreceived, strata=qarku, col_name=qvKod)
#' @references
#' Simplified wrapper around dplyr::anti_join()
#' @import
#' dplyr
#' @export
smissing <- function(sampdf, colldf, strata, col_name) {
  col_name <- enquo(col_name)
  strata <- enquo(strata)
  col_namex <- quo_name(enquo(col_name))
  stratax <- quo_name(enquo(strata))
  recd <- colldf %>% group_by(!!strata) %>% summarise(received=length(!!strata))
  smiss <- anti_join(sampdf, colldf, by=col_namex)
  smiss2 <- smiss %>% group_by(!!strata) %>% summarise(missing=length(!!strata))
  remiss <- merge(recd,smiss2,by=stratax) %>% mutate(pctreceived=100*(received/(received+missing)), pctmissing=100*(missing/(received+missing)))
  print(remiss)
}
