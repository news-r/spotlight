
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
places <- spot_annotate(text, types = "DBpedia:Place")
#> Annotating 2 documents.
#> 100% annotating document: 2 [====================================================================] eta: 0s

knitr::kable(places)
```

|                    text                    | confidence | support |     types     | sparql | policy    | resource\_URI                                    | resource\_support | resource\_types                                                                                                                                            | resource\_surfaceForm | resource\_offset | resource\_similarityScore | resource\_percentageOfSecondRank |
| :----------------------------------------: | ---------: | ------: | :-----------: | :----- | :-------- | :----------------------------------------------- | ----------------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------- | ---------------: | ------------------------: | -------------------------------: |
| Donald Trump is probably in Washington DC. |        0.5 |       0 | DBpedia:Place |        | whitelist | <http://dbpedia.org/resource/Washington_(state)> |             43066 | Wikidata:Q3455524,Schema:Place,Schema:AdministrativeArea,DBpedia:Region,DBpedia:PopulatedPlace,DBpedia:Place,DBpedia:Location,DBpedia:AdministrativeRegion | Washington            |               28 |                 0.5234317 |                        0.4408709 |
