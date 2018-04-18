#' Setup
#'
#' @export
spot_setup <- function(language = NULL){

  if(!is.null(language))
    .check_language(language)
  else
    options(SPOTLIGHT_LANGUAGE = language)
}
