#' Filter empty documents.
#'
#' Filter empty documents.
#'
#' @param text vector or list of text.
#'
#' @examples
#' text <- c("Some text", "", "", "More text")
#'
#' spot_filter(text)
#'
#' @export
spot_filter <- function(text) UseMethod("spot_filter")

#' @rdname spot_filter
#' @noRd
#' @method spot_filter list
#' @export
spot_filter.list <- function(text){
  lapply(text, function(x) x[nchar(x) > 0L])
}

#' @rdname spot_filter
#' @noRd
#' @method spot_filter character
#' @export
spot_filter.character <- function(text){
  text[nchar(text) > 0L]
}
