
#' R6 Class Representing the Safari Zone from Pokemon Blue (1998)
#'
#' @description
#' An \code{\link[R6]{R6Class}} object to simulate simplified gameplay elements
#' of the Safari Zone sub-area from \emph{Pokemon Blue} (1998).
#'
#' @details
#' The first generation of \emph{Pokemon} games were developed for the Nintendo
#' Game Boy by Game Freak (\url{https://www.gamefreak.co.jp/}) and published by
#' Nintendo (\url{https://www.nintendo.com}). Pokemon as a property is owned by
#' The Pokemon Company (\url{https://www.pokemon.co.jp/}).
#'
#' @export
#'
#' @examples
#' \dontrun{sz <- safar6::SafariZone}

SafariZone <- R6::R6Class("SafariZone",

  public = list(

    # Fields ----

    #' @field steps Steps remaining (500 at start).
    steps = 500,
    #' @field balls Safari Balls remaining (30 at start).
    balls = 30,
    #' @field captures Wild Pokemon captured (0 at start).
    captures = 0,

    # Methods ----

    #' @description
    #' Create a new Safari Zone object.
    #' @return A new `SafariZone` object.
    initialize = function() {
      cat(
        "Welcome to the SAFARI ZONE!\n",
        "For just $500, you can catch all the Pokemon you want in the park!\n",
        "Would you like to join the hunt?\n",
        "> YES NO\n",
        "That'll be $500 please!\n",
        "We only use a special POKe BALL here.\n",
        "BLUE received 30 SAFARI BALLs!\n",
        "We'll call you on the PA when you run out of time or SAFARI BALLs!\n"
      )
    },

    #' @description
    #' Create a new Safari Zone print method.
    #' @return A console message with steps and balls remaining.
    #' @examples \dontrun{
    #'     sz <- safar6::SafariZone  # initialise class
    #'     sz$print()  # print the object, see stats
    #' }
    print = function() {
      cat(paste0(self$steps, "/500\n"))
      cat(paste0("BALLx", self$balls, "\n"))
      cat(paste0("Captured", self$captures, "\n"))
    },

    #' @description
    #' Simulate the pause function from the original game.
    #' @return A console message with steps and balls remaining.
    #' @seealso \code{\link{print}}
    #' @examples \dontrun{
    #'     sz <- safar6::SafariZone  # intialise class
    #'     sz$pause()  # 'pause' the game, see stats
    #' }
    pause = function() {
      self$print()
    },

    #' @description
    #' Take a step in the Safari Zone.
    #' @return Either nothing, or a wild encounter.
    #' @examples \dontrun{
    #'     sz <- safar6::SafariZone  # initialise class
    #'     sz$step()   # take step
    #'     sz$pause()  # steps has reduced by one
    #' }
    step = function() {

      # You must have steps remaining to continue
      if (self$steps == 0 | self$balls == 0) {
        cat("PA: Ding-dong!\nTime's up!\nPA: Your SAFARI GAME is over!\n",
            "Did you get a good haul?\nCome again!")
      } else if (self$steps > 0) {
        self$steps <- self$steps - 1
        cat(paste0(self$steps, "/500\n"))
      }

      # Encounter
      if (sample(0:255, 1) < 30) {  # base encounter rate is 30 in Safari Zone

        # Select species/level by encounter rate
        pkmn <-
          dplyr::slice_sample(safar6::pokemon, weight_by = encounter_rate)
        cat("Wild", pkmn$species, paste0("L", pkmn$level), "appeared!\n")

        # Starting encounter details
        encounter_active <- TRUE
        status_eating <- 0
        status_angry  <- 0
        status_catch <- pkmn$catch_base
        status_break_free <- NULL

        # Encounter while loop
        while (encounter_active == TRUE) {

          # Adjust eating/anger status at start of turn
          if (status_eating > 0) {
            cat("Wild", pkmn$species, "is eating!\n")
            status_eating <- status_eating - 1
          } else if (status_angry > 0) {
            cat("Wild", pkmn$species, "is angry!\n")
            status_angry <- status_angry - 1
            if (status_angry == 0) {
              status_catch <- pkmn$catch_base  # returns to original rate
            }
          }

          # Player's turn ----

          # Ask player to choose from options
          cat("------------------------\n",
              paste0("BALLx", self$balls),
              " (1)     BAIT (2)\nTHROW ROCK (3)  RUN (4)\n",
              sep = "")
          player_action <- readline("Selection: ")

          # Ifelse chain dependent on player selection
          if (player_action %in% c("BALL", "1")) {  # throw Safari Ball

            # Reduce balls by 1
            cat("BLUE used SAFARI BALL!\n")
            self$balls <- self$balls - 1

            # Break free based on catch rate and Safari Ball RNG
            if (status_catch < sample(0:150, 1) ) {
              cat("Darn! The POKeMON broke free!\n")
              status_break_free <- TRUE
            }

            # Catch chance based on Pokemon HP
            F1 <- (pkmn$hp_base * 255) / 12
            F2 <- max(pkmn$hp_base / 4, 1)
            F3 <- min(F1 / F2, 255)

            # If it didn't break free and HP-related RNG is met
            if (!isTRUE(status_break_free) & sample(0:255, 1) <= F3) {
              cat("All right!\n", pkmn$species, "was caught!\n",
                  pkmn$species, " was transferred to BILL's PC!\n",
                  sep = "")
              self$captures <- self$captures + 1  # increment catch count
              status_break_free <- NULL  # reset break-free status
              encounter_active <- FALSE  # break loop
            }

          } else if (player_action %in% c("BAIT", "2")) {  # throw bait

            cat("BLUE threw some BAIT.\n")

            # Make status adjustments
            status_catch <- floor(status_catch / 2)  # adjust catch rate
            status_eating <- status_eating + sample(1:5, 1)  # adjust +1 to 5
            status_angry <- 0  # reset anger status

          } else if (player_action %in% c("ROCK", "3")) {  # throw rock

            cat("BLUE threw a ROCK.\n")

            # Make status adjustments
            status_catch <- min(status_catch * 2, 255)  # adjust catch rate
            status_angry <- status_angry + sample(1:5, 1)  # adjust +1 to 5
            status_eating <- 0  # reset eating status

          } else if (player_action %in% c("RUN", "4")) {  # exit encounter

            cat("Got away safely!")
            encounter_active <- FALSE  # braek loop

          }

          # Wild Pokemon's turn ----

          # Speed-based factor with status impacts
          X <- (pkmn$speed_base %% 256) * 2
          if (status_eating > 0) {
            X <- X / 4
          } else if (status_angry > 0) {
            X <- min(X * 2, 255)
          }
          if (sample(0:255, 1) < X) {  # RNG
            cat("Wild", pkmn$species, "ran away!\n")
            encounter_active <- FALSE  # break loop
          }

          # Check if balls remain
          if (self$balls == 0) {
            cat("PA: Ding-dong!\nTime's up!\nPA: Your SAFARI GAME is over!\n",
                "Did you get a good haul?\nCome again!", sep = "")
            encounter_active <- FALSE   # break loop
          }

        }

      }

      invisible(self)

    }

  )
)
