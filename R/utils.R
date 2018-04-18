
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

.call_api <- function(x){
  
  uri <- .base_url()

  response <- httr::POST(
    uri,
    encode = "form",
    body = list(
    text = as.character(x)
    )
  )
  
  httr::stop_for_status(response)
  
  results <- .parse(response)
  
  if(getOption("SPOTLIGHT_RESPONSE") == "data.frame")
    results <- spot_as_data_frame(results)
    
  results
  
}

spot_as_data_frame <- function(l){
  if(length(l$Resources) > 0){
    l$Resources <- do.call(plyr::"rbind.fill", lapply(l$Resources, as.data.frame))
    n <- names(l$Resources)
    names(l$Resources) <- gsub("X.", "", n)
  }
  
  l
}

.parse <- function(x){
  httr::content(x)
}
