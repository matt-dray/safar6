.onAttach<- function(libname, pkgname) {
  packageStartupMessage(
    paste0(
      "{safar6}\n",
      "Start game: x <- SafariZone$new()\n",
      "Take a step: x$step()"
    )
  )
}
