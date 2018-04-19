
<!-- README.md is generated from README.Rmd. Please edit that file -->
spotlight
=========

[![Travis-CI Build Status](https://travis-ci.org/JohnCoene/spotlight.svg?branch=master)](https://travis-ci.org/JohnCoene/spotlight) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/spotlight?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/spotlight)

R wrapper to the [DBpedia Spotlight API](http://www.dbpedia-spotlight.org/). All [official documentation](https://github.com/dbpedia-spotlight/dbpedia-spotlight-model) is online.

> It is a tool for automatically annotating mentions of DBpedia resources in text, providing a solution for linking unstructured information sources to the Linked Open Data cloud through DBpedia. -- DBpedia Spotlight

Installation
------------

You can install spotlight from github with:

``` r
# install.packages("devtools")
devtools::install_github("JohnCoene/spotlight")
```

Example
-------

``` r
# Data to extract entities from 
data <- data.frame(
  text = c(
    "This text is about France.",
    "szzza dasdazsd azzsd daawq" # garbage
  )
)

results <- spot(data, text) # get entities

spot_df(results) # attempts to transform to data.frame
#> Warning: Function still in development
#> [[1]]
#> [[1]]$`@text`
#> [1] "This text is about France."
#> 
#> [[1]]$`@confidence`
#> [1] "0.5"
#> 
#> [[1]]$`@support`
#> [1] "0"
#> 
#> [[1]]$`@types`
#> [1] ""
#> 
#> [[1]]$`@sparql`
#> [1] ""
#> 
#> [[1]]$`@policy`
#> [1] "whitelist"
#> 
#> [[1]]$Resources
#> [[1]]$Resources[[1]]
#>                                  @URI @support                 @types
#> 1: http://dbpedia.org/resource/France   256130         Wikidata:Q6256
#> 2: http://dbpedia.org/resource/France   256130           Schema:Place
#> 3: http://dbpedia.org/resource/France   256130         Schema:Country
#> 4: http://dbpedia.org/resource/France   256130 DBpedia:PopulatedPlace
#> 5: http://dbpedia.org/resource/France   256130          DBpedia:Place
#> 6: http://dbpedia.org/resource/France   256130       DBpedia:Location
#> 7: http://dbpedia.org/resource/France   256130        DBpedia:Country
#>    @surfaceForm @offset   @similarityScore @percentageOfSecondRank
#> 1:       France      19 0.9978697399657521    7.244508064056807E-4
#> 2:       France      19 0.9978697399657521    7.244508064056807E-4
#> 3:       France      19 0.9978697399657521    7.244508064056807E-4
#> 4:       France      19 0.9978697399657521    7.244508064056807E-4
#> 5:       France      19 0.9978697399657521    7.244508064056807E-4
#> 6:       France      19 0.9978697399657521    7.244508064056807E-4
#> 7:       France      19 0.9978697399657521    7.244508064056807E-4
#> 
#> 
#> 
#> [[2]]
#> [[2]]$`@text`
#> [1] "szzza dasdazsd azzsd daawq"
#> 
#> [[2]]$`@confidence`
#> [1] "0.5"
#> 
#> [[2]]$`@support`
#> [1] "0"
#> 
#> [[2]]$`@types`
#> [1] ""
#> 
#> [[2]]$`@sparql`
#> [1] ""
#> 
#> [[2]]$`@policy`
#> [1] "whitelist"
```

You can also send larger texts, like a 38 pages long report.

``` r
library(pdftools)
uri <- "http://www3.weforum.org/docs/WEF_43923_Brazil_COMP_Lab_report_2018.pdf"
download.file(uri, destfile = "text.pdf", mode = "wb")
text <- pdf_text("text.pdf")

results <- spot(text) # get entities
```
