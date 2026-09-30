
<!-- README.md is generated from README.Rmd. Please edit that file -->

# electionsFR

<!-- badges: start -->

<!-- badges: end -->

The goal of electionsFR is to offer a set of functions to easily
download and clean French electoral data from the public archive
data-gouv.fr .

## Installation

You can install the development version of electionsFR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("FredCassor/electionsFR")
```

## Example

This is a basic example which shows you how to get access to datasets
which refer to the Presidential election in 2002, published by the
French Ministry of the Interior:

``` r
library(electionsFR)
get_presidentielle(2002)
```
