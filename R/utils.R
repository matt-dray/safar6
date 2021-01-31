
#' Typewriter-style Concatenate and Print
#'
#' Input text-string and output one character at a time given a delay. Aims to
#' mimic the Pokemon Blue progressive text reveal, like typewriter output.
#'
#' @param x A character string of length 1.
#' @param sleep Numeric, length 1. System delay in seconds.
#'
#' @return Output to console.
#'
#' @examples \dontrun{ cat_typewriter("Example text.", 0.2) }
cat_tw <- function(x, sleep = 0.02) {

  x_paste <- paste0(x, collapse = "")

  x_chars <- strsplit(x_paste, "\\b")[[1]]

  for (char in x_chars) {
    cat(char)
    Sys.sleep(sleep)
  }

}
