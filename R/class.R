
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
    #' @field captures Count of wild Pokemon captured (0 at start).
    captures = 0,
    #' @field bills_pc Details of Wild Pokemon captured (empty at start).
    bills_pc = data.frame(species = NULL, level = NULL),

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
      cat(paste0(self$steps, "/500\n"),
          paste0("BALLx", self$balls, "\n"),
          paste0("Transferred to BILL's PC: ", self$captures, "\n"),
          sep = "")
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
        cat(paste0(self$steps, "/500\n"))
      }

      # Encounter
      if (sample(0:255, 1) < 30) {  # base encounter rate is 30 in Safari Zone

        # Select species/level by encounter rate
        pkmn <-
          dplyr::slice_sample(safar6::pokemon, weight_by = encounter_rate)
        cat("Wild", pkmn$species, paste0("L", pkmn$level), "appeared!\n")

        # Set individual values and calculated Hp and speed
        iv_atk <- sample(1:15, 1)
        iv_def <- sample(1:15, 1)
        iv_spd <- sample(1:15, 1)
        iv_spc <- sample(1:15, 1)
        iv_hp <- 0
        if (iv_atk %% 2 != 0) {
          iv_hp <- iv_hp + 8
        }
        if (iv_def %% 2 != 0){
          iv_hp <- iv_hp + 4
        }
        if (iv_spd %% 2 != 0){
          iv_hp <- iv_hp + 2
        }
        if (iv_spc %% 2 != 0){
          iv_hp <- iv_hp + 1
        }
        pkmn$hp_indiv <-
          floor((((pkmn$hp_base + iv_hp) * 2) * pkmn$level) / 100) + pkmn$level + 10
        pkmn$speed_indiv <-
          floor((((pkmn$speed_base + iv_spd) * 2) * pkmn$level) / 100) + 5

        # Starting encounter details
        encounter_active <- TRUE
        status_eating <- 0
        status_angry  <- 0
        status_catch <- pkmn$catch_base

        # Encounter while loop
        while (encounter_active == TRUE) {

          # Adjust eating/anger status ----

          # Decrease counter at start of turn
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

            # Ball ----
            cat("BLUE used SAFARI BALL!\n")

            # Reduce balls by 1
            self$balls <- self$balls - 1

            # Define HP-related catch factor
            F1 <- (pkmn$hp_indiv * 255) / 12  # 12 is Safari Ball factor
            F2 <- max(pkmn$hp_indiv / 4, 1)  # divide by 4, but can't be 0
            F3 <- min(F1 / F2, 255)  # divide but can't be >255

            # Define wobble factor
            w <- (floor((pkmn$catch_base * 100) / 150) * F3) / 255  # wobble
            s <- 1  # wobble delay in seconds

            # Generate RNG for ball and HP
            ball_rng <- sample(0:150, 1)
            hp_rng <- sample(0:255, 1)

            # Ifelse break free or catch
            if (status_catch < ball_rng) {

              cat("Wobble...\n")
              Sys.sleep(s)
              cat("Darn! The POKéMON broke free!\n")

            } else if (status_catch >= ball_rng) {

              if (F3 >= hp_rng) {

                # Wobble and capture
                cat("Wobble... ")
                Sys.sleep(s)
                cat("Wobble... ")
                Sys.sleep(s)
                cat("Wobble...\n")
                Sys.sleep(s)
                cat("All right!\n", pkmn$species, " was caught!\n",
                    pkmn$species, " was transferred to BILL's PC!\n",
                    sep = "")

                # Update capture count and Bill's PC
                self$captures <- self$captures + 1
                self$bills_pc <- rbind(
                  self$bills_pc,
                  data.frame(species = pkmn$species, level = pkmn$level)
                )

                encounter_active <- FALSE  # break loop

              } else {  # second break-free chance

                if (w < 10) {
                  cat("The ball missed the POKeMON!\n")
                } else if (w %in% 10:29) {
                  cat("Wobble...\n")
                  Sys.sleep(s)
                  cat("Darn! The POKéMON broke free!\n")
                } else if (w %in% 30:69) {
                  cat("Wobble... ")
                  Sys.sleep(s)
                  cat("Wobble...\n")
                  Sys.sleep(s)
                  cat("Aww! It appeared to be caught!\n")
                } else if (w > 70) {
                  cat("Wobble... ")
                  Sys.sleep(s)
                  cat("Wobble... ")
                  Sys.sleep(s)
                  cat("Wobble...\n")
                  Sys.sleep(s)
                  cat("Shoot! It was so close too!\n")
                }

              }

            }

          } else if (player_action %in% c("BAIT", "2")) {  # throw bait

            # Choice: bait ----
            cat("BLUE threw some BAIT.\n")

            # Make status adjustments
            status_catch <- floor(status_catch / 2)  # halve catch rate
            status_eating <- status_eating + sample(1:5, 1)  # adjust +1 to 5
            status_eating <- min(status_eating, 255) # cap at 255
            status_angry <- 0  # reset anger status

          } else if (player_action %in% c("ROCK", "3")) {  # throw rock

            # Choice: rock ----
            cat("BLUE threw a ROCK.\n")

            # Make status adjustments
            status_catch <- min(status_catch * 2, 255)  # double catch rate
            status_angry <- status_angry + sample(1:5, 1)  # adjust +1 to 5
            status_angry <- min(status_angry, 255) # cap at 255
            status_eating <- 0  # reset eating status

          } else if (player_action %in% c("RUN", "4")) {  # exit encounter

            # Choice: run ----
            cat("Got away safely!")
            encounter_active <- FALSE  # break loop

          }

          # Wild Pokemon's turn ----

          # Chance to run away
          X <- (pkmn$speed_indiv %% 256) * 2
          if (status_eating > 0) {
            X <- X / 4
          } else if (status_angry > 0) {
            X <- min(X * 2, 255)
          }
          if (sample(0:255, 1) < X) {  # RNG
            cat("Wild", pkmn$species, "ran away!\n")
            encounter_active <- FALSE  # break loop
          }

          # Check counters ----

          # Check if balls remain
          if (self$balls == 0 | self$steps == 0) {

            # End game notice and results
            cat("------------------------\n",
                "PA: Ding-dong!\nTime's up!\nPA: Your SAFARI GAME is over!\n",
                "Did you get a good haul?\nCome again!\n",
                "------------------------\nResult: ",
                self$captures, " transferred to BILL's PC\n",
                sep = "")

            # Print details of catches
            if (self$captures > 0) {
              print(self$bills_pc)
            }

            encounter_active <- FALSE   # break loop
          }

        }

      }

      invisible(self)

    }

  )

)
