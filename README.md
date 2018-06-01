
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

Examples
--------

``` r
# Data to extract entities from 
text = c(
  "The World Economic Forum's headquarters are located in Geneva.",
  "szzza dasdazsd azzsd daawq", # garbage
  "" # empty document
)

# remove empty documents
text <- spot_filter(text)

# Annotate
results <- spot_annotate(text)

# Annotate specific types
places <- spot_annotate(text, types = "DBpedia:Place")
(places <- spot_resources(places)) # simplifies => extracts resources
#>                                  URI support
#> 1 http://dbpedia.org/resource/Geneva   15258
#>                                                                                                    types
#> 1 Wikidata:Q486972,Schema:Place,DBpedia:Settlement,DBpedia:PopulatedPlace,DBpedia:Place,DBpedia:Location
#>   surfaceForm offset    similarityScore percentageOfSecondRank
#> 1      Geneva     55 0.9995874431494471   2.384137727638211E-4
```

You can also send larger texts, like a 38 pages long report.

``` r
library(pdftools)
uri <- "http://www3.weforum.org/docs/WEF_43923_Brazil_COMP_Lab_report_2018.pdf"
download.file(uri, destfile = "text.pdf", mode = "wb")
text <- pdf_text("text.pdf")

results <- spot(text) # get entities
```
