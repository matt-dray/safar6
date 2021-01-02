#' Data for Encounters with Wild Pokemon
#'
#' A dataset containing the Pokemon you can encounter in the Safari Zone in
#' Pokemon Blue and their statistics.
#'
#' @format A data frame with 10 rows and 9 variables:
#' \describe{
#'   \item{game}{The Pokemon generation 1 game variant. \code{BLUE} only for now.}
#'   \item{area}{The area of the Safari Zone (\code{CENTER} only for now)}
#'   \item{tile}{The terrain on which the player is standing (\code{GRASS} only for now).}
#'   \item{species}{The encounter Pokemon's species.}
#'   \item{level}{The encounter Pokemon's level.}
#'   \item{catch_base}{The base catch rate for the species.}
#'   \item{speed_base}{The base speed for the species.}
#'   \item{slot}{Encounter rate slot, which determines \code{encounter_rate}}
#'   \item{encounter_rate}{Chance of encounter.}
#' }
#' @source \url{https://github.com/pret/pokered} and \url{https://bulbapedia.bulbagarden.net/}
"pokemon"
#> [1] "pokemon"
