#' Albania 2017 Election Results by Polling Station
#'
#' Data set containing 2017 Albania election results by polling station published by the Central Election Commission and opened by the Coalition of Domestic Observers & Democracy International.
#'
#' @format A data frame with 5362 rows and 45 variables
#' \describe{
#' \item{qarku}{district, 12 in total}
#' \item{Q_ID}{geocode for district}
#' \item{bashkia}{municipality, 61 in total}
#' \item{BAS_ID}{geocode for municipality}
#' \item{zaz}{election area zone, 90 in total}
#' \item{njesiaAdministrative}{village, 373 in total}
#' \item{COM_ID}{geocode for village}
#' \item{qvKod}{polling station identifier}
#' \item{zgjedhes}{number of total registered voters}
#' \item{meshkuj}{number of male registered voters}
#' \item{femra}{number of female registered voters}
#' \item{totalSeats}{number of seats contested by district}
#' \item{vendndodhja}{name of polling center containing polling stations}
#' \item{ambienti}{type of polling center, 5 in total}
#' \item{totalVoters}{number of total registered voters that cast ballots}
#' \item{femVoters}{number of female registered voters that cast ballots}
#' \item{maleVoters}{number of male registered voters that cast ballots}
#' \item{unusedBallots}{number of ballots not used}
#' \item{damagedBallots}{number of ballots damaged}
#' \item{ballotsCast}{number of total ballots cast}
#' \item{invalidVotes}{number of ballots cast that were invalidated}
#' \item{validVotes}{number of valid ballots cast}
#' \item{lsi}{number of ballots cast for LSI}
#' \item{ps}{number of ballots cast for PS}
#' \item{pkd}{number of ballots cast for PKD}
#' \item{sfida}{number of ballots cast for SFIDA}
#' \item{pr}{number of ballots cast for PR}
#' \item{pd}{number of ballots cast for PD}
#' \item{pbdksh}{number of ballots cast for PBDKSH}
#' \item{adk}{number of ballots cast for ADK}
#' \item{psd}{number of ballots cast for PSD}
#' \item{ad}{number of ballots cast for AD}
#' \item{frd}{number of ballots cast for FRD}
#' \item{pds}{number of ballots cast for PDS}
#' \item{pdiu}{number of ballots cast for PDIU}
#' \item{aak}{number of ballots cast for AAK}
#' \item{mega}{number of ballots cast for MEGA}
#' \item{pksh}{number of ballots cast for PKSH}
#' \item{apd}{number of ballots cast for APD}
#' \item{libra}{number of ballots cast for LIBRA}
#' \item{psSeats}{number of seats won by PS}
#' \item{pdSeats}{number of seats won by PD}
#' \item{lsiSeats}{number of seats won by LSI}
#' \item{pdiuSeats}{number of seats won by PDIU}
#' \item{psdSeats}{number of seats won by PSD}
#' }
#'
#' @source \url{https://albaniaelectiondata.herokuapp.com/}
#'
"albania"

#' Albania 2017 CDO Election Observation Data Findings on Opening Process
#'
#' Data set containing 2017 Albania election observation findings on polling station opening process by the Coalition of Domestic Observers (CDO)
#' CDO conducted a statistically-based observation (SBO) exercise, deploying observers to a random sample of polling stations for the 25 June 2017 Albanian elections.
#' This is a subset of observation data collected by CDO observers that includes data that was used to perform statistical analysis.
#'
#' @format A data frame with 524 rows and 19 variables
#' \describe{
#' \item{qarku}{district, 12 in total}
#' \item{psID}{polling station identifier}
#' \item{votersList}{number of registered voters at the polling station}
#' \item{ballotPapers}{number of ballot papers at the polling station}
#' \item{pubPriv}{type of polling station, public or private}
#' \item{openTime}{time when polling station opening, in 30 minute ranges}
#' \item{numKommish}{number of commissioners present at polling station}
#' \item{secrecyOpen}{yes-no if polling station enabled voters to cast ballots in secrecy, po or jo}
#' \item{movementOpen}{yes-no if polling station provided sufficient space to vote, po or jo}
#' \item{removeMatInside}{yes-no if campaign materials were removed from inside polling station, po or jo}
#' \item{removeMatOutside}{yes-no if campaign materials were removed from outside polling station, po or jo}
#' \item{pvComplete}{yes-no if commissioners completed the opening record checklist sheet, po or jo}
#' \item{boxChecked}{yes-no if commissioners checked to ensure the ballot box was empty before opening, po or jo}
#' \item{boxSealed}{yes-no if commissioners sealed the ballot box to prevent ballot tampering, po or jo}
#' \item{recordBox}{yes-no if commissioners recorded the seal number on the ballot box, po or jo}
#' \item{centerMat}{yes-no if there were all election materials were available at the polling station, po or jo}
#' \item{blindTools}{yes-no if the polling station was equipped for blind voters, po or jo}
#' \item{disabledTools}{yes-no-partially if the polling station was equipped for disabled voters, po or jo or pjeserisht}
#' \item{overallOpen}{very good-good-problematic-very problematic an overall assessment of the opening process, shummir,mir,meprob,shumprob}
#' }
#'
#' @source \url{https://ona.io/cdo/35080/216662}
#'
"opening"
