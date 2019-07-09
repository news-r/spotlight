
# spotlight

[![Travis build
status](https://travis-ci.org/news-r/spotlight.svg?branch=master)](https://travis-ci.org/news-r/spotlight)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/spotlight?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/spotlight)

R wrapper to the [DBpedia Spotlight
API](http://www.dbpedia-spotlight.org/). All [official
documentation](https://github.com/dbpedia-spotlight/dbpedia-spotlight-model)
is online.

> It is a tool for automatically annotating mentions of DBpedia
> resources in text, providing a solution for linking unstructured
> information sources to the Linked Open Data cloud through DBpedia. -
> DBpedia Spotlight

Global options are set with `spot_set_opts`.

## Installation

You can install spotlight from github with:

``` r
# install.packages("devtools")
devtools::install_github("news-r/spotlight")
```

## Examples

``` r
library(spotlight)

# Data to extract entities from 
text = c(
  "Donald Trump is probably in Washington DC.",
  "szzza dasdazsd azzsd daawq", # garbage
  "" # empty document
)

# remove empty documents
text <- spot_filter(text)

# Annotate
results <- spot_annotate(text)
#> Annotating 2 documents.
#> 100% annotating document: 2 [==================================] eta: 0s

# Annotate specific types
(places <- spot_annotate(text, types = "DBpedia:Place"))
#> Annotating 2 documents.
#> 100% annotating document: 2 [==================================] eta: 0s
#> [[1]]
#> [[1]]$`@text`
#> [1] "Donald Trump is probably in Washington DC."
#> 
#> [[1]]$`@confidence`
#> [1] "0.5"
#> 
#> [[1]]$`@support`
#> [1] "0"
#> 
#> [[1]]$`@types`
#> [1] "DBpedia:Place"
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
#> [1] "http://dbpedia.org/resource/Washington_(state)"
#> 
#> [[1]]$Resources[[1]]$`@support`
#> [1] "43066"
#> 
#> [[1]]$Resources[[1]]$`@types`
#> [1] "Wikidata:Q3455524,Schema:Place,Schema:AdministrativeArea,DBpedia:Region,DBpedia:PopulatedPlace,DBpedia:Place,DBpedia:Location,DBpedia:AdministrativeRegion"
#> 
#> [[1]]$Resources[[1]]$`@surfaceForm`
#> [1] "Washington"
#> 
#> [[1]]$Resources[[1]]$`@offset`
#> [1] "28"
#> 
#> [[1]]$Resources[[1]]$`@similarityScore`
#> [1] "0.5234317431792824"
#> 
#> [[1]]$Resources[[1]]$`@percentageOfSecondRank`
#> [1] "0.4408708905047457"
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
#> [1] "DBpedia:Place"
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
