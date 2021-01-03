
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
#' @examples \dontrun{ sz <- safar6::SafariZone$new() }
SafariZone <- R6::R6Class("SafariZone",

  public = list(

    # Fields ----

    #' @field steps Steps remaining (500 at start).
    steps = 500,
    #' @field balls Safari Balls remaining (30 at start).
    balls = 30,
    #' @field captures Count of wild Pokemon captured (0 at start).
    captures = 0,
    #' @field bills_pc Dataframe of wild Pokemon captured (empty at start).
    bills_pc = data.frame(nickname = NULL, species = NULL, level = NULL),

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
        "We'll call you on the PA when you run out of time or SAFARI BALLs!\n",
        sep = ""
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
      cat(
        paste0(self$steps, "/500\n"),
        paste0("BALLx", self$balls, "\n"),
        paste0("BILL's PC: ", self$captures, "\n"),
        sep = ""
      )
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
    #'     sz$step()   # take step, prints steps remaining
    #' }
    step = function() {

      # Adjust and check steps ----

      # Reduce step count field by 1
      if (self$steps > 0) {
        self$steps <- self$steps - 1
        cat(paste0(self$steps, "/500\n"))  # let player know steps remaining
      }

      # Check if steps have run out, end game if so
      if (self$steps == 0) {

        # End-game notice and results
        cat(
          "------------------------\n",
          "PA: Ding-dong!\nTime's up!\nPA: Your SAFARI GAME is over!\n",
          "Did you get a good haul?\nCome again!\n",
          "------------------------\nResult: ",
          self$captures, " transferred to BILL's PC\n",
          sep = ""
        )

        # Print details of any catches
        if (self$captures > 0) { print(self$bills_pc) }

      }

      # Begin encounter ----

      if (sample(0:255, 1) < 30 &  # Safari Zone base encounter rate is 30
          self$steps > 0 & self$balls > 0) {  # balls/steps must be non-zero

        # The encounter has begun, set variable
        # The while-Loop of turns is broken when this gets modified to FALSE
        encounter_active <- TRUE

        # Wild Pokemon selection, IV calculation ----

        # Select species/level weighted by encounter rate (slot position)
        pkmn <- safar6::pokemon[sample(1:nrow(safar6::pokemon), 1,
                                       prob = safar6::pokemon$encounter_rate), ]

        # Print notice of the wild Pokemon selected
        cat("Wild", pkmn$species, paste0("L", pkmn$level), "appeared!\n")

        # Set individual values (IVs)
        iv_atk <- sample(1:15, 1)  # attack
        iv_def <- sample(1:15, 1)  # defence
        iv_spd <- sample(1:15, 1)  # speed
        iv_spc <- sample(1:15, 1)  # 'special'

        # The HP IV depends on the other IVs and whether they're odd
        iv_hp <- 0
        if (iv_atk %% 2 != 0) { iv_hp <- iv_hp + 8 }
        if (iv_def %% 2 != 0) { iv_hp <- iv_hp + 4 }
        if (iv_spd %% 2 != 0) { iv_hp <- iv_hp + 2 }
        if (iv_spc %% 2 != 0) { iv_hp <- iv_hp + 1 }

        # Calculate the individual HP and speed for the wild Pokemon
        pkmn$hp_indiv <-
          floor((((pkmn$hp_base + iv_hp) * 2) * pkmn$level) / 100) + pkmn$level + 10
        pkmn$speed_indiv <-
          floor((((pkmn$speed_base + iv_spd) * 2) * pkmn$level) / 100) + 5

        # Set variables for modifiable statuses that impact catch chance
        status_eating <- 0
        status_angry  <- 0
        status_catch <- pkmn$catch_base

        # Start the turns of the encounter ----

        # Turns loop from player to Pokemon until encounter_active is FALSE
        while (encounter_active == TRUE & self$steps > 0) {

          # Adjust eating/anger status ----

          # Pokemon's accrued anger/eating values depleted by 1 if non-zero
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
          cat(
            "------------------------\n",
            paste0("BALLx", self$balls),
            " (1)     BAIT (2)\nTHROW ROCK (3)  RUN (4)\n",
            sep = ""
          )

          # Collect player's selection (expecting the corresponding number)
          player_action <- readline("Selection: ")

          # Ifelse chain dependent on player's choice
          if (player_action %in% c("BALL", "1")) {  # throw Safari Ball

            # Chose to throw ball ----
            cat("BLUE used SAFARI BALL!\n")

            # Reduce ball count by 1
            self$balls <- self$balls - 1

            # Define HP-related catch factor, 'F'
            F1 <- (pkmn$hp_indiv * 255) / 12  # 12 is Safari Ball factor
            F2 <- max(pkmn$hp_indiv / 4, 1)  # divide by 4, but can't be 0
            F3 <- min(F1 / F2, 255)  # divide but can't be >255

            # Define wobble factor, 'W'
            W <- (floor((pkmn$catch_base * 100) / 150) * F3) / 255  # wobble
            S <- 1  # wobble delay in seconds

            # Generate RNG for ball and HP
            ball_rng <- sample(0:150, 1)  # 150 specific to Safari Ball
            hp_rng <- sample(0:255, 1)

            # Ifelse for capture
            if (status_catch < ball_rng) {  # ball-related catch fail

              # Breakout
              cat("Wobble...\n")
              Sys.sleep(S)
              cat("Darn! The POKeMON broke free!\n")

            } else if (status_catch >= ball_rng) {  # ball-related catch success

              if (F3 >= hp_rng) {  # capture

                # Wobble
                cat("Wobble... ")
                Sys.sleep(S)
                cat("Wobble... ")
                Sys.sleep(S)
                cat("Wobble...\n")
                Sys.sleep(S)

                # Print capture notice, ask for nickname
                cat("All right!\n", pkmn$species, " was caught!\n",
                    "Do you want to give a nickname to ", pkmn$species, "?",
                    sep = "")

                # Collect player's response
                name_response <- readline(paste0( "Selection (YES/NO): "))

                # Prompt for nickname if yes, otherwise nickname is species name
                if (name_response == "NO") {
                  pkmn$nickname <- pkmn$species
                  cat(pkmn$species, " was transferred to BILL's PC!\n")
                } else if (name_response == "YES") {
                  nickname <- readline("Nickname: ")
                  pkmn$nickname <- nickname
                  cat(nickname, "was transferred to BILL's PC!\n")
                }

                # Incrementcapture counter by 1
                self$captures <- self$captures + 1

                # Append captured Pokemon information to Bill's PC field
                self$bills_pc <- rbind(
                  self$bills_pc,
                  data.frame(
                    nickname = pkmn$nickname,
                    species = pkmn$species,
                    level = pkmn$level
                  )
                )

                # Break loop, Pokemon was captured
                encounter_active <- FALSE

              } else {  # second break-free chance, based on wobble factor

                # HP always max in Safari Zone, so multi-wobble unlikely
                if (W < 10) {
                  cat("The ball missed the POKeMON!\n")
                } else if (W %in% 10:29) {
                  cat("Wobble...\n")
                  Sys.sleep(S)
                  cat("Darn! The POKeMON broke free!\n")
                } else if (W %in% 30:69) {
                  cat("Wobble... ")
                  Sys.sleep(S)
                  cat("Wobble...\n")
                  Sys.sleep(S)
                  cat("Aww! It appeared to be caught!\n")
                } else if (W > 70) {
                  cat("Wobble... ")
                  Sys.sleep(S)
                  cat("Wobble... ")
                  Sys.sleep(S)
                  cat("Wobble...\n")
                  Sys.sleep(S)
                  cat("Shoot! It was so close too!\n")
                }

              }

            }

          } else if (player_action %in% c("BAIT", "2")) {  # throw bait

            # Chose to throw bait ----
            cat("BLUE threw some BAIT.\n")

            # Make status adjustments
            status_catch  <- floor(status_catch / 2)  # halve catch rate
            status_eating <- status_eating + sample(1:5, 1)  # adjust +1 to 5
            status_eating <- min(status_eating, 255) # cap at 255
            status_angry  <- 0  # reset anger status

          } else if (player_action %in% c("ROCK", "3")) {  # throw rock

            # Chose to throw a rock ----
            cat("BLUE threw a ROCK.\n")

            # Make status adjustments
            status_catch  <- min(status_catch * 2, 255)  # double catch rate
            status_angry  <- status_angry + sample(1:5, 1)  # adjust +1 to 5
            status_angry  <- min(status_angry, 255) # cap at 255
            status_eating <- 0  # reset eating status

          } else if (player_action %in% c("RUN", "4")) {  # exit encounter

            # Chose to run ----
            cat("Got away safely!")

            # Break loop, player has voluntarily left the encounter
            encounter_active <- FALSE

          }

          # Wild Pokemon's turn ----

          # Define chance to run away, 'X', based on individual speed
          X <- (pkmn$speed_indiv %% 256) * 2

          # Adjust run chance based on eating/anger status
          if (status_eating > 0) {
            X <- X / 4  # flee chance reduced to a quarter
          } else if (status_angry > 0) {
            X <- min(X * 2, 255)  # flee chance doubled
          }

          # Set flee RNG
          flee_rng <- sample(0:255, 1)

          if (encounter_active == TRUE & flee_rng < X) {
            cat("Wild", pkmn$species, "ran away!\n")
            encounter_active <- FALSE  # break loop, Pokemon has fled
          }

          # Check ball counter ----

          # Check if balls remain
          if (self$balls == 0) {

            # End game notice and results
            cat(
              "------------------------\n",
              "PA: Ding-dong!\nTime's up!\nPA: Your SAFARI GAME is over!\n",
              "Did you get a good haul?\nCome again!\n",
              "------------------------\nResult: ",
              self$captures, " transferred to BILL's PC\n",
              sep = ""
            )

            # Print details of any catches
            if (self$captures > 0) { print(self$bills_pc) }

            # Game is over, no more steps can be taken, set field to 0
            self$steps <- 0

            # Break loop, player is out of balls and the game is over
            encounter_active <- FALSE

          }

        }

      }

      invisible(self)

    }

  )

)
