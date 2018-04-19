#' Spot
#'
#' Spot entities.
#'
#' @param data A data.frame or vector.
#' @param text Name of column containing text.
#'
#' @examples
#' \dontrun{
#' data <- data.frame(
#'   text = c(
#'     "This text is about France.",
#'     "This text is about Ecology."
#'   )
#' )
#'
#' (results <- spot(data, text))
#' }
#'
#' @importFrom methods is
#'
#' @rdname spot
#' @export
spot <- function(data, text) UseMethod("spot")

#' @rdname spot
#' @method spot data.frame
#' @export
spot.data.frame <- function(data, text){

  if(missing(data) || missing(text))
    stop("Missing data or text", call. = FALSE)

  txt <- deparse(substitute(text))

  data <- .get_data(data, txt)

  if(getOption("SPOTLIGHT_QUIET") == FALSE)
    message("Annotating ", length(data), " documents.")

  lapply(data, .call_api)
}

#' @rdname spot
#' @method spot character
#' @export
spot.character <- function(data, text){

  if(missing(data))
    stop("Missing data", call. = FALSE)

  if(getOption("SPOTLIGHT_QUIET") == FALSE)
    message("Annotating ", length(data), " documents.")

  lapply(data, .call_api)

}

#' Widen
#'
#' Widen data.frame.
#'
#' @param data Data.frame as returned by \code{\link{spot}}.
#' @examples
#' \dontrun{
#' results <- spot("This text is about France.")
#' wide <- spot_df(results)
#' }
#'
#'
#' @export
spot_df <- function(data){
  warning("Function still in development", call. = FALSE)
  lapply(data, .spot_widen)
}
