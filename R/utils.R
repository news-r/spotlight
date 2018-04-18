
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

.spot_rename <- function(x){
  x <- as.data.frame(x) 
  # split
  type <- x[, grepl("types", names(x))]
  notype <- x[, !grepl("types", names(x))]
  
  typez <- sapply(type[1,], function(x){
    strsplit(as.character(x), ":")[[1]]
  })
  
  typenames <- typez[1,]
  types <- typez[2,]
  
  t <- as.data.frame(t(as.matrix(types)))
  names(t) <- typenames
  cbind.data.frame(notype, t)
}

.spot_widen <- function(data){
  if(length(data$Resources) > 0){
    col <- names(data$Resources)[grepl("types", names(data$Resources))]
    data$Resources <- splitstackshape::cSplit(data$Resources, col, sep = ",")
    data$Resources <- .spot_rename(data$Resources)
  }
  data
}
