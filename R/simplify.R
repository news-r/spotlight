#' Tidy Results
#'
#' Tidy results as data.frame.
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
#' tidy_annotations(results)
#' }
#'
#' @export
tidy_annotations <- function(data){
  docs <- 1:length(data)

  data <- purrr::map2(data, docs, function(x, y){
    if(!is.null(x))
      x$id <- y
    return(x)
  }) %>% 
    purrr::keep(function(x){
      !is.null(x)
    }) 

  base <- purrr::map_dfr(data, function(x) {
    x$Resources <- NULL
    tibble::as_tibble(x)
  }) 

  docs <- unique(base$id)

  res <- purrr::map(data, "Resources") %>% 
    purrr::map2_dfr(docs, function(x, y){

      if(is.null(x))
        return(tibble::as_tibble())

      res <- purrr::map_dfr(x, tibble::as_tibble)
      
      res$id <- y
      return(res)
    })

  nms <- clean_names(names(res))
  nms <- paste0("resource_", nms)
  names(res) <- nms

  res <- dplyr::inner_join(base, res, by = c("id" = "resource_id"))
  
  names(res) <- clean_names(names(res))
  res %>% 
    dplyr::mutate(
      confidence = as.numeric(confidence),
      support = as.numeric(support),
      resource_support = as.integer(resource_support),
      resource_offset = as.integer(resource_offset),
      resource_similarityScore = as.numeric(resource_similarityScore),
      resource_percentageOfSecondRank = as.numeric(resource_percentageOfSecondRank)
    )
}

clean_names <- function(x){
  gsub("\\@", "", x)
}