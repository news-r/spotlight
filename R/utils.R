globalVariables(
  c(
    "confidence",
    "id",
    "resource_offset",
    "resource_percentageOfSecondRank",
    "resource_similarityScore",
    "resource_support",
    "support"
  )
)


.valid_languages <- function(){
  c("en", "de", "nl", "fr", "it", "ru", "es", "pt", "hu", "tr")
}

.valid_results <- function(){
  c("list", "data.frame")
}

.check_language <- function(x){
  if(!x %in% .valid_languages())
    stop("Invalid language", call. = FALSE)
}

.check_results <- function(x){
  if(!x %in% .valid_results())
    stop("Invalid response", call. = FALSE)
}

.get_data <- function(data, text){
  data[[text]]
}

.base_url <- function(){
  base <- getOption("SPOTLIGHT_BASE_URL")
  language <- getOption("SPOTLIGHT_LANGUAGE")
  paste0(base, language)
}

.build_url <- function(endpoint = "/annotate"){
  base <- .base_url()
  paste0(base, endpoint)
}

.get_response <- function(x, uri, query){

  query$text <- as.character(x)

  response <- httr::POST(
    uri,
    encode = "form",
    body = query
  )

  if(getOption("SPOTLIGHT_QUIET") == FALSE && httr::status_code(response) != 200)
    cat(crayon::red("failed"), "to retrieve entities\n")

  response
}

.call_api <- function(x, uri, query, pb){

  response <- .get_response(x, uri, query)

  code <- httr::status_code(response)
  pb$tick()

  retries <- getOption("SPOTLIGHT_RETRY")
  r <- 1
  while(code != 200 && r < retries){

    r <- r + 1

    if(getOption("SPOTLIGHT_QUIET") == FALSE)
      cat("Attempt ", crayon::yellow(paste0("#", r), "\n"))

    uri <- .base_url()

    response <- .get_response(x, uri, query)

    code <- httr::status_code(response)

    Sys.sleep(getOption("SPOTLIGHT_SLEEP"))
  }

  Sys.sleep(getOption("SPOTLIGHT_SLEEP"))

  if(code == 200)
    results <- .parse(response)
  else
    results <- list()

  results

}

.parse <- function(x){
  httr::content(x)
}
