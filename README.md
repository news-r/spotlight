
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
results <- spot(text)
results[[1]] # print first
#> $`@text`
#> [1] "The World Economic Forum's headquarters are located in Geneva."
#> 
#> $`@confidence`
#> [1] "0.5"
#> 
#> $`@support`
#> [1] "0"
#> 
#> $`@types`
#> [1] ""
#> 
#> $`@sparql`
#> [1] ""
#> 
#> $`@policy`
#> [1] "whitelist"
#> 
#> $Resources
#> $Resources[[1]]
#> $Resources[[1]]$`@URI`
#> [1] "http://dbpedia.org/resource/World_Economic_Forum"
#> 
#> $Resources[[1]]$`@support`
#> [1] "2743"
#> 
#> $Resources[[1]]$`@types`
#> [1] "Wikidata:Q43229,Wikidata:Q24229398,DUL:SocialPerson,DUL:Agent,Schema:Organization,DBpedia:Organisation,DBpedia:Agent"
#> 
#> $Resources[[1]]$`@surfaceForm`
#> [1] "World Economic Forum"
#> 
#> $Resources[[1]]$`@offset`
#> [1] "4"
#> 
#> $Resources[[1]]$`@similarityScore`
#> [1] "1.0"
#> 
#> $Resources[[1]]$`@percentageOfSecondRank`
#> [1] "0.0"
#> 
#> 
#> $Resources[[2]]
#> $Resources[[2]]$`@URI`
#> [1] "http://dbpedia.org/resource/Geneva"
#> 
#> $Resources[[2]]$`@support`
#> [1] "15258"
#> 
#> $Resources[[2]]$`@types`
#> [1] "Wikidata:Q486972,Schema:Place,DBpedia:Settlement,DBpedia:PopulatedPlace,DBpedia:Place,DBpedia:Location"
#> 
#> $Resources[[2]]$`@surfaceForm`
#> [1] "Geneva"
#> 
#> $Resources[[2]]$`@offset`
#> [1] "55"
#> 
#> $Resources[[2]]$`@similarityScore`
#> [1] "0.9995874431494471"
#> 
#> $Resources[[2]]$`@percentageOfSecondRank`
#> [1] "2.384137727638211E-4"
```

You can also send larger texts, like a 38 pages long report.

``` r
library(pdftools)
uri <- "http://www3.weforum.org/docs/WEF_43923_Brazil_COMP_Lab_report_2018.pdf"
download.file(uri, destfile = "text.pdf", mode = "wb")
text <- pdf_text("text.pdf")

results <- spot(text) # get entities
```
