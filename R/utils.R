
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
  paste0(base, language, "/annotate")
}

.get_response <- function(x){
  uri <- .base_url()

  response <- httr::POST(
    uri,
    encode = "form",
    body = list(
      text = as.character(x)
    )
  )

  if(getOption("SPOTLIGHT_QUIET") == FALSE && httr::status_code(response) != 200)
    cat(crayon::red("Failed"), "to retrieve entities\n")

  response
}

.call_api <- function(x){

  response <- .get_response(x)

  code <- httr::status_code(response)

  retries <- getOption("SPOTLIGHT_RETRY")
  r <- 1
  while(code != 200 && r < retries){

    r <- r + 1

    if(getOption("SPOTLIGHT_QUIET") == FALSE)
      cat("Attempt", crayon::yellow(paste0("#", r)))

    uri <- .base_url()

    response <- .get_response(x)

    code <- httr::status_code(response)

    Sys.sleep(getOption("SPOTLIGHT_SLEEP"))
  }

  if(code == 200)
    results <- .parse(response)
  else
    results <- list()

  results

}

.parse <- function(x){
  httr::content(x)
}

.spot_widen <- function(data){
  if(length(data$Resources) > 0)
    data$Resources <- lapply(data$Resources, .spot_to_data_frame, "@types")
  data
}

.spot_to_data_frame <- function(x, col){
  if(length(x[[col]]))
    x <- splitstackshape::cSplit(x, col, sep = ",", direction = "long")
  x
}
