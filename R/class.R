
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
#' @examples
#' \dontrun{sz <- safar6::SafariZone}

SafariZone <- R6::R6Class("SafariZone",

  public = list(

    # Fields ----

    # Overworld status

    #' @field steps Steps remaining (500 at start).
    steps = 500,
    #' @field balls Safari Balls remaining (30 at start).
    balls = 30,
    #' @field captures Wild Pokemon captured (0 at start).
    captures = 0,

    # Latest encounter attributes

    #' @field pkmn_sp Species of Pokemon in latest encounter.
    pkmn_sp = "MISSINGNO.",
    #' @field pkmn_lvl Level of Pokemon in latest encounter.
    pkmn_lvl = NULL,
    #' @field pkmn_hp Hit Points (HP) of Pokemon in latest encounter.
    pkmn_hp = NULL,
    #' @field pkmn_catch_base Base catch rate of Pokemon in latest encounter.
    pkmn_catch_base = NULL,
    #' @field pkmn_catch_mod Modified base catch rate of Pokemon in latest encounter.
    pkmn_catch_mod = NULL,
    #' @field pkmn_speed_base Base speed of Pokemon in latest encounter.
    pkmn_speed_base = NULL,
    #' @field pkmn_speed_ind Individual speed of Pokemon in latest encounter.
    pkmn_speed_ind = NULL,
    #' @field pkmn_angry Anger status of Pokemon in latest encounter.
    pkmn_angry = 0L,
    #' @field pkmn_eating Eating status of Pokemon in latest encounter.
    pkmn_eating = 0L,

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
      if (self$steps > 0) {
        self$steps <- self$steps - 1
      } else if (self$steps == 0) {
        cat("No more steps!")
      }

      # Reminder of steps
      cat(paste0(self$steps, "/500\n"))

      # Encounter
      if (sample(0:255, 1) < 30) {  # base encounter rate is 30 in Safari Zone

        # Select species/level by encounter rate
        encounter_pkmn <-
          dplyr::slice_sample(pokemon, weight_by = encounter_rate)

        # Print encounter details
        cat("Wild", encounter_pkmn$species,
            paste0("L", encounter_pkmn$level), "appeared!\n")

        ## code below should be in a while loop so that you get player turn
        ## followed by pokemon turn until you run, it's caught or it runs

        encounter_active <- TRUE  # encounter is active to start

        while (encounter_active == TRUE) {

          # # Adjust anger and eating status at start of turn
          # if (private$pkmn_angry > 0) {
          #   cat("Wild [x] is angry!")
          #   self$pkmn_angry <- self$pkmn_angry - 1
          #   if (self$pkmn_angry == 0) {
          #     self$pkmn_c <- self$pkmn_base_c
          #   }
          # } else if (self$pkmn_eating > 0) {
          #   cat("Wild [x] is eating!")
          #   self$pkmn_eating <- self$pkmn_eating - 1
          # }

          # Ask player to choose from options
          player_action <- readline(
            paste0("BALLx", self$balls, " (1), BAIT (2), ROCK (3), RUN (4)? "))

          # Ifelse chain dependent on player selection
          if (player_action %in% c("BALL", "1")) {  # throw Safari Ball

            # Reduce balls by 1
            cat("BLUE used SAFARI BALL!")
            self$balls <- self$balls - 1

            # # Calculate catch chance
            # Rstar <- sample(0:150, 1)  # ball RNG
            # F1 <- (private$pkmn_hp * 255) / 12  # HP factor
            # F2 <- max(private$pkmn_hp / 4, 1)
            # F3 <- min(F1 / F2, 255)
            #
            # # Fail
            # if (private$pkmn_catch_base < Rstar) {
            #   cat("Darn! The POKeMON broke free!\nWild",
            #       encounter_pkmn$species, "ran!")
            # }
            #
            # # Second chance
            # R2 <- sample(0:255, 1)
            # if (R2 <= F1) {
            #   cat("caught")
            #   private$captures <- private$captures + 1
            # }

          } else if (player_action %in% c("BAIT", "2")) {  # throw bait

            cat("BLUE threw some BAIT.\nWild",
                encounter_pkmn$species, "is eating!")

            # self$pkmn_catch <- floor(private$pkmn_catch_base / 2)
            # self$pkmn_eating <- private$pkmn_eating + sample(1:5, 1)
            # self$pkmn_angry <- 0

          } else if (player_action %in% c("ROCK", "3")) {  # throw rock

            cat("BLUE threw a ROCK.\nWild", encounter_pkmn$species, "is angry!")

            # private$pkmn_catch <- min(private$pkmn_catch_base * 2, 255)
            # private$pkmn_angry <- private$pkmn_angry + sample(1:5, 1)
            # private$pkmn_eating <- 0

          } else if (player_action %in% c("RUN", "4")) {  # exit encounter
            cat("Got away safely!")
            encounter_active <- FALSE
          }

          # # Wild Pokemon's turn
          # X <- (self$pkmn_speed %% 256) * 2
          # if (X > 255) {
          #   cat("Wild", encounter_pkmn$species, "ran away!")
          # }
          # if (self$pkmn_angry > 0) { X <- min(X * 2, 255) }
          # if (self$pkmn_eating > 0) { X <- X / 4 }
          # R <- sample(0:255, 1)
          # if (R < X) {
          #   cat("Wild", encounter_pkmn$species, "ran away!")
          # }

        }

      }

      invisible(self)

    }

  )
)
