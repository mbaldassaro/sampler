#' Removes duplicate observations within collected data
#' @param df object containing data frame of collected data
#' @param col_name variable within data frame by which to filter for duplicate values
#' @return Returns table of all data based on unique values within collected data
#' @examples
#' aldupe <- rsamp(df=albania, n=390, rep=TRUE)
#' dedupe(df=aldupe, col_name=qvKod)
#' @import
#' dplyr
#' @export
dedupe <- function(df, col_name) {
 col_name <- enquo(col_name)
 df %>% group_by(!!col_name) %>% distinct(.keep_all=TRUE)
}
