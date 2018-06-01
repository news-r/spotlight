
#' Extract Resources
#'
#' Extract Resources from results.
#'
#' @param data Data as returned by \code{\link{spot_annotate}}.
#'
#' @section Resources extracted:
#' \itemize{
#'   \item{\code{URI}}
#'   \item{\code{support}}
#'   \item{\code{types}}
#'   \item{\code{surfaceFrom}}
#'   \item{\code{offset}}
#'   \item{\code{similarityScore}}
#'   \item{\code{percentageOfSecondRank}}
#' }
#'
#' @examples
#' \dontrun{
#' results <- spot("This text is about France.")
#' spot_resources(results)
#' }
#'
#' @export
spot_resources <- function(data){
  res <- purrr::map(data, "Resources")
  res <- purrr::map_df(res, as.data.frame)
  n <- names(res)
  n <- gsub("X\\.|\\.1", "", n)
  names(res) <- n
  res
}
