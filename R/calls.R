#' POST
#'
#' @rdname spot_post
#' @export
spot_post <- function(data, text) UseMethod("spot_post")

#' @rdname spot_post
#' @method spot_post data.frame
#' @export
spot_post.data.frame <- function(data, text){

  if(missing(data) || missing(text))
    stop("Missing data or text", call. = FALSE)

  txt <- deparse(substitute(text))

  data <- .get_data(data, txt)

  lapply(data, .call_api())

}

#' @rdname spot_post
#' @method spot_post character
#' @export
spot_post.character <- function(data){

  if(missing(data))
    stop("Missing data", call. = FALSE)

}
