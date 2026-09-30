
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

## Examples

### Presidential election data

This is a basic example which shows you how to download datasets which
refer to the Presidential election in 2002, published by the French
Ministry of the Interior:

``` r
library(electionsFR)
get_presidentielle(2002)
```

### General elections

For getting data on general elections, this is an example of downloading
files on general elections in 2007 and saved in a the sub directory
`elections`:

``` r
get_legislatives(2007, exdir = "elections")
```
