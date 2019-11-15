
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
places <- spot_annotate(text)
#> Annotating 2 documents.
#> 100% annotating document: 2 [==================================] eta: 0s

knitr::kable(places)
```

| text                                       | confidence | support | types | sparql | policy    | resource\_URI                                    | resource\_support | resource\_types                                                                                                                                            | resource\_surfaceForm | resource\_offset | resource\_similarityScore | resource\_percentageOfSecondRank |
| :----------------------------------------- | ---------: | ------: | :---- | :----- | :-------- | :----------------------------------------------- | ----------------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------- | ---------------: | ------------------------: | -------------------------------: |
| Donald Trump is probably in Washington DC. |        0.5 |       0 |       |        | whitelist | <http://dbpedia.org/resource/Donald_Trump>       |             14792 | <Http://xmlns.com/foaf/0.1/Person,Wikidata:Q5,Wikidata:Q24229398,Wikidata:Q215627,DUL:NaturalPerson,DUL:Agent,Schema:Person,DBpedia:Person,DBpedia:Agent>  | Donald Trump          |                0 |                 0.9997958 |                        0.0001923 |
| Donald Trump is probably in Washington DC. |        0.5 |       0 |       |        | whitelist | <http://dbpedia.org/resource/Washington_(state)> |             43066 | Wikidata:Q3455524,Schema:Place,Schema:AdministrativeArea,DBpedia:Region,DBpedia:PopulatedPlace,DBpedia:Place,DBpedia:Location,DBpedia:AdministrativeRegion | Washington            |               28 |                 0.5234317 |                        0.4408709 |
| Donald Trump is probably in Washington DC. |        0.5 |       0 |       |        | whitelist | <http://dbpedia.org/resource/DC_Comics>          |             18800 | Wikidata:Q43229,Wikidata:Q24229398,DUL:SocialPerson,DUL:Agent,Schema:Organization,DBpedia:Publisher,DBpedia:Organisation,DBpedia:Company,DBpedia:Agent     | DC                    |               39 |                 0.7179406 |                        0.1938080 |
