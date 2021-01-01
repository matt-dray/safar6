
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

        cat("Wild", self$pkmn_sp, "appeared!")

        # choose a pokemon from the lookup, set fields
        # initiate routine for player action
        # initiate routine for pokemon action
        # cease if run away, reinitiate player action otherwise

      }

      invisible(self)

    }

  )
)
