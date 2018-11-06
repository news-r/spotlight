.onLoad <- function(libname, pkgname) {
  options(
    SPOTLIGHT_BASE_URL = "http://api.dbpedia-spotlight.org/",
    SPOTLIGHT_LANGUAGE = "en",
    SPOTLIGHT_RESPONSE = "list",
    SPOTLIGHT_RETRY = 25,
    SPOTLIGHT_SLEEP = .5,
    SPOTLIGHT_QUIET = !interactive()
  )
}
