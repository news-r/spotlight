#' Annotate
#'
#' Annotate entities.
#'
#' @param text A data.frame containing a column named "text" or a vector of class character.
#' @param url URL to be annotated.
#' @param confidence Confidence score for disambiguation / linking.
#' @param support How prominent is this entity in Lucene Model, i.e. number of inlinks in Wikipedia.
#' @param types Types filter (Eg.:\code{DBpedia:Place}).
#' @param sparql SPARQL filtering.
#' @param policy (whitelist) select all entities that have the same type; (blacklist) -
#' select all entities that have not the same type.
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
#' (results <- spot_annotate(data))
#' }
#'
#' @importFrom methods is
#'
#' @rdname spot_annotate
#' @export
spot_annotate <- function(text, url = NULL, confidence = NULL, support = NULL, types = NULL, sparql = NULL, policy = NULL) UseMethod("spot_annotate")

#' @rdname spot_annotate
#' @method spot_annotate data.frame
#' @export
spot_annotate.data.frame <- function(text, url = NULL, confidence = NULL, support = NULL,
  types = NULL, sparql = NULL, policy = NULL){

  if(missing(text))
    stop("Missing text", call. = FALSE)

  #txt <- deparse(substitute(text))

  text <- .get_data(text, "text")

  if(getOption("SPOTLIGHT_QUIET") == FALSE)
    cat("Annotating", crayon::blue(length(text)), "documents.")

  query <- list(
    url = url,
    confidence = confidence,
    support = support,
    types = types,
    sparql = sparql,
    policy = policy
  )

  lapply(text, .call_api, uri = .build_url(), query = query)
}

#' @rdname spot_annotate
#' @method spot_annotate character
#' @export
spot_annotate.character <- function(text, url = NULL, confidence = NULL, support = NULL,
                                    types = NULL, sparql = NULL, policy = NULL){

  if(missing(text))
    stop("Missing text", call. = FALSE)

  if(getOption("SPOTLIGHT_QUIET") == FALSE)
    cat("Annotating", crayon::blue(length(text)), "documents.")

  query <- list(
    url = url,
    confidence = confidence,
    support = support,
    types = types,
    sparql = sparql,
    policy = policy
  )

  lapply(text, .call_api, uri = .build_url(), query = query)

}

#' Spot
#' 
#' Spot urls.
#'
#' @inheritParams spot_annotate
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
#' (results <- spot_spot(data))
#' }
#'
#' @rdname spot_spot
#' @export
spot_spot <- function(text, url = NULL, confidence = NULL, support = NULL, types = NULL, sparql = NULL, policy = NULL) UseMethod("spot_spot")

#' @rdname spot_spot
#' @method spot_spot data.frame
#' @export
spot_spot.data.frame <- function(text, url = NULL, confidence = NULL, support = NULL,
  types = NULL, sparql = NULL, policy = NULL){

  if(missing(text))
    stop("Missing text", call. = FALSE)

  #txt <- deparse(substitute(text))

  text <- .get_data(text, "text")

  if(getOption("SPOTLIGHT_QUIET") == FALSE)
    cat("Annotating", crayon::blue(length(text)), "documents.\n")

  query <- list(
    url = url,
    confidence = confidence,
    support = support,
    types = types,
    sparql = sparql,
    policy = policy
  )

  lapply(text, .call_api, uri = .build_url("/spot"), query = query)
}

#' @rdname spot_spot
#' @method spot_spot character
#' @export
spot_spot.character <- function(text, url = NULL, confidence = NULL, support = NULL,
                                    types = NULL, sparql = NULL, policy = NULL){

  if(missing(text))
    stop("Missing text", call. = FALSE)

  if(getOption("SPOTLIGHT_QUIET") == FALSE)
    cat("Spotting", crayon::blue(length(text)), "documents.\n")

  query <- list(
    url = url,
    confidence = confidence,
    support = support,
    types = types,
    sparql = sparql,
    policy = policy
  )

  lapply(text, .call_api, uri = .build_url("/spot"), query = query)

}

#' Candidates
#' 
#' Find candidate urls.
#'
#' @inheritParams spot_annotate
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
#' (results <- spot_spot(data))
#' }
#'
#' @rdname spot_candidate
#' @export
spot_candidate <- function(text, url = NULL, confidence = NULL, support = NULL, types = NULL, sparql = NULL, policy = NULL) UseMethod("spot_spot")

#' @rdname spot_candidate
#' @method spot_candidate data.frame
#' @export
spot_candidate.data.frame <- function(text, url = NULL, confidence = NULL, support = NULL,
  types = NULL, sparql = NULL, policy = NULL){

  if(missing(text))
    stop("Missing text", call. = FALSE)

  #txt <- deparse(substitute(text))

  text <- .get_data(text, "text")

  if(getOption("SPOTLIGHT_QUIET") == FALSE)
    cat("Annotating", crayon::blue(length(text)), "documents.\n")

  query <- list(
    url = url,
    confidence = confidence,
    support = support,
    types = types,
    sparql = sparql,
    policy = policy
  )

  lapply(text, .call_api, uri = .build_url("/spot"), query = query)
}

#' @rdname spot_candidate
#' @method spot_candidate character
#' @export
spot_candidate.character <- function(text, url = NULL, confidence = NULL, support = NULL,
  types = NULL, sparql = NULL, policy = NULL){

  if(missing(text))
    stop("Missing text", call. = FALSE)

  if(getOption("SPOTLIGHT_QUIET") == FALSE)
    cat("Spotting", crayon::blue(length(text)), "documents.\n")

  query <- list(
    url = url, 
    confidence = confidence,
    support = support,
    types = types,
    sparql = sparql,
    policy = policy
  )

  lapply(text, .call_api, uri = .build_url("/candidates"), query = query)

}