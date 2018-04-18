#' Setup
#' 
#' Setup session.
#' 
#' @param language Language of text.
#' @param response Format of response.
#' 
#' @section Languages:
#' \itemize{
#'   \item{\code{en} English}
#'   \item{\code{de} German}
#'   \item{\code{nl} Dutch}
#'   \item{\code{fr} French}
#'   \item{\code{it} Italian}
#'   \item{\code{ru} Russian}
#'   \item{\code{es} Spanish}
#'   \item{\code{pt} Portuguese}
#'   \item{\code{hu} Hungarian}
#'   \item{\code{tr} Turkish}
#' }
#' 
#' @section Response:
#' \itemize{
#'   \item{\code{list}}
#'   \item{\code{data.frame}}
#' }
#' 
#' @examples 
#' spot_setup(language = "fr")
#'
#' @export
spot_setup <- function(language = NULL, response = NULL){

  if(!is.null(language)){
    .check_language(language)
    options(SPOTLIGHT_LANGUAGE = language)
  }

  
  if(!is.null(response)){
    .check_results(response)
    options(SPOTLIGHT_RESPONSE = response)
  }  
}


