
<!-- README.md is generated from README.Rmd. Please edit that file -->

# electionFR

<!-- badges: start -->

<!-- badges: end -->

The goal of electionFR is to offer a set of functions to easily download
and clean French electoral data from the public archive data-gouv.fr.

## Installation

You can install the development version of electionFR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("FredCassor/electionFR")
```

## Example

This is a basic example which shows you how to get the datasets
ressources released by the French Ministry of the Interior, available
online:

``` r
library(electionFR)
data("ressources")
head(ressources)
#> # A tibble: 6 × 30
#>   dataset.id         dataset.title dataset.slug dataset.url dataset.organization
#>   <chr>              <chr>         <chr>        <chr>       <chr>               
#> 1 6aa4644c63519c97b… Élections sé… elections-s… https://ww… Ministère de l'inté…
#> 2 6aa4644c63519c97b… Élections sé… elections-s… https://ww… Ministère de l'inté…
#> 3 6aa184a81686fc48d… Élections sé… elections-s… https://ww… Ministère de l'inté…
#> 4 6aa183dbcbcae583a… Elections sé… elections-s… https://ww… Ministère de l'inté…
#> 5 6a884f10fa89847e4… Stock et flu… stock-et-fl… https://ww… Ministère de l'inté…
#> 6 6a884f10fa89847e4… Stock et flu… stock-et-fl… https://ww… Ministère de l'inté…
#> # ℹ 25 more variables: dataset.organization_id <chr>, dataset.license <chr>,
#> #   dataset.private <lgl>, dataset.archived <lgl>, id <chr>, url <chr>,
#> #   title <chr>, description <chr>, filetype <chr>, type <chr>, format <chr>,
#> #   mime <chr>, filesize <dbl>, checksum.type <chr>, checksum.value <chr>,
#> #   created_at <dttm>, modified <dttm>, downloads <dbl>,
#> #   harvest.issued_at <lgl>, harvest.modified_at <lgl>,
#> #   harvest.last_update <lgl>, schema_name <chr>, schema_version <chr>, …
```
