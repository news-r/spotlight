
<!-- README.md is generated from README.Rmd. Please edit that file -->

# spotlight

[![Travis-CI Build
Status](https://travis-ci.org/JohnCoene/spotlight.svg?branch=master)](https://travis-ci.org/JohnCoene/spotlight)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/spotlight?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/spotlight)

R wrapper to the [DBpedia Spotlight
API](http://www.dbpedia-spotlight.org/).

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
spot_setup(response = "data.frame")

data <- data.frame(
  text = c(
    "This text is about France.",
    "This text is about Ecology."
  )
)

(results <- spot(data, text))
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
#>                                  URI support
#> 1 http://dbpedia.org/resource/France  256130
#>                                                                                                              types
#> 1 Wikidata:Q6256,Schema:Place,Schema:Country,DBpedia:PopulatedPlace,DBpedia:Place,DBpedia:Location,DBpedia:Country
#>   surfaceForm offset    similarityScore percentageOfSecondRank
#> 1      France     19 0.9978697399657521   7.244508064056807E-4
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
```
