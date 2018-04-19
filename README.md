
<!-- README.md is generated from README.Rmd. Please edit that file -->
spotlight
=========

[![Travis-CI Build Status](https://travis-ci.org/JohnCoene/spotlight.svg?branch=master)](https://travis-ci.org/JohnCoene/spotlight) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/spotlight?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/spotlight)

R wrapper to the [DBpedia Spotlight API](http://www.dbpedia-spotlight.org/). All [official documentation](https://github.com/dbpedia-spotlight/dbpedia-spotlight-model) is online.

> It is a tool for automatically annotating mentions of DBpedia resources in text, providing a solution for linking unstructured information sources to the Linked Open Data cloud through DBpedia. - DBpedia Spotlight

Global options are set with `spot_set_opts`.

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
text = c(
  "The World Economic Forum's headquarters are located in Geneva.",
  "szzza dasdazsd azzsd daawq", # garbage
  "" # empty document
)

# remove empty documents
text <- spot_filter(text)

# get entities
(results <- spot(text))
#> [[1]]
#> [[1]]$`@text`
#> [1] "The World Economic Forum's headquarters are located in Geneva."
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
#> [[1]]$Resources[[1]]$`@URI`
#> [1] "http://dbpedia.org/resource/World_Economic_Forum"
#> 
#> [[1]]$Resources[[1]]$`@support`
#> [1] "2743"
#> 
#> [[1]]$Resources[[1]]$`@types`
#> [1] "Wikidata:Q43229,Wikidata:Q24229398,DUL:SocialPerson,DUL:Agent,Schema:Organization,DBpedia:Organisation,DBpedia:Agent"
#> 
#> [[1]]$Resources[[1]]$`@surfaceForm`
#> [1] "World Economic Forum"
#> 
#> [[1]]$Resources[[1]]$`@offset`
#> [1] "4"
#> 
#> [[1]]$Resources[[1]]$`@similarityScore`
#> [1] "1.0"
#> 
#> [[1]]$Resources[[1]]$`@percentageOfSecondRank`
#> [1] "0.0"
#> 
#> 
#> [[1]]$Resources[[2]]
#> [[1]]$Resources[[2]]$`@URI`
#> [1] "http://dbpedia.org/resource/Geneva"
#> 
#> [[1]]$Resources[[2]]$`@support`
#> [1] "15258"
#> 
#> [[1]]$Resources[[2]]$`@types`
#> [1] "Wikidata:Q486972,Schema:Place,DBpedia:Settlement,DBpedia:PopulatedPlace,DBpedia:Place,DBpedia:Location"
#> 
#> [[1]]$Resources[[2]]$`@surfaceForm`
#> [1] "Geneva"
#> 
#> [[1]]$Resources[[2]]$`@offset`
#> [1] "55"
#> 
#> [[1]]$Resources[[2]]$`@similarityScore`
#> [1] "0.9995874431494471"
#> 
#> [[1]]$Resources[[2]]$`@percentageOfSecondRank`
#> [1] "2.384137727638211E-4"
#> 
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
