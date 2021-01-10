.onAttach <- function(libname, pkgname) {  # nolint
  packageStartupMessage(
    paste0(
      "{safar6}\n",
      "Start game: x <- safari_zone$new()\n",
      "Take a step: x$step()"
    )
  )
}
