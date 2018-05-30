#' Identifies missing points between sample and collected data
#' @param sampdf object containing data frame of sample points
#' @param colldf object containing data frame of collected data
#' @param col_name common variable (i.e. key) in data frames by which to check for missing points
#' @return Returns table of sample points missing from collected data
#' @examples
#' alsample <- rsamp(df=albania, 544)
#' alreceived <- rsamp(df=alsample, 390)
#' rmissing(sampdf=alsample, colldf=alreceived, col_name=qvKod)
#' @references
#' Simplified wrapper around dplyr::anti_join()
#' @import
#' dplyr
#' @export
rmissing <- function(sampdf, colldf, col_name) {
  col_name <- quo_name(enquo(col_name))
  anti_join(sampdf, colldf, by=col_name)
}
