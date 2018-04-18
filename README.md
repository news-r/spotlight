
<!-- README.md is generated from README.Rmd. Please edit that file -->

# spotlight

[![Travis-CI Build
Status](https://travis-ci.org/JohnCoene/spotlight.svg?branch=master)](https://travis-ci.org/JohnCoene/spotlight)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/spotlight?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/spotlight)

R wrapper to the [DBpedia Spotlight
API](http://www.dbpedia-spotlight.org/). All [official
documentation](https://github.com/dbpedia-spotlight/dbpedia-spotlight-model)
is online.

> It is a tool for automatically annotating mentions of DBpedia
> resources in text, providing a solution for linking unstructured
> information sources to the Linked Open Data cloud through DBpedia. –
> DBpedia Spotlight

## Installation

You can install spotlight from github with:

``` r
# install.packages("devtools")
devtools::install_github("JohnCoene/spotlight")
```

## Example

``` r
spot_setup(response = "data.frame") # return data.frame

# Fake data to extract entities from 
data <- data.frame(
  text = c(
    "This text is about France.",
    "This text is about Ecology.",
    "szzza dasdazsd azzsd daawq" # garbage
  )
)

results <- spot(data, text) # get entities

spot_widen(results) # Widen data.frames
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
#>                                  URI support surfaceForm offset
#> 1 http://dbpedia.org/resource/France  256130      France     19
#> 2 http://dbpedia.org/resource/France  256130      France     19
#> 3 http://dbpedia.org/resource/France  256130      France     19
#> 4 http://dbpedia.org/resource/France  256130      France     19
#> 5 http://dbpedia.org/resource/France  256130      France     19
#> 6 http://dbpedia.org/resource/France  256130      France     19
#> 7 http://dbpedia.org/resource/France  256130      France     19
#>      similarityScore percentageOfSecondRank         entity     type
#> 1 0.9978697399657521   7.244508064056807E-4          Q6256 Wikidata
#> 2 0.9978697399657521   7.244508064056807E-4          Place   Schema
#> 3 0.9978697399657521   7.244508064056807E-4        Country   Schema
#> 4 0.9978697399657521   7.244508064056807E-4 PopulatedPlace  DBpedia
#> 5 0.9978697399657521   7.244508064056807E-4          Place  DBpedia
#> 6 0.9978697399657521   7.244508064056807E-4       Location  DBpedia
#> 7 0.9978697399657521   7.244508064056807E-4        Country  DBpedia
#> 
#> 
#> [[2]]
#> [[2]]$`@text`
#> [1] "This text is about Ecology."
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
#> 
#> 
#> [[3]]
#> [[3]]$`@text`
#> [1] "szzza dasdazsd azzsd daawq"
#> 
#> [[3]]$`@confidence`
#> [1] "0.5"
#> 
#> [[3]]$`@support`
#> [1] "0"
#> 
#> [[3]]$`@types`
#> [1] ""
#> 
#> [[3]]$`@sparql`
#> [1] ""
#> 
#> [[3]]$`@policy`
#> [1] "whitelist"
```
