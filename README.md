
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

This is a basic example which shows you how to get the datasets
ressources released by the French Ministry of the Interior, available
online:

``` r
library(electionsFR)
data("ressources")
colnames(ressources)
#>  [1] "dataset.id"              "dataset.title"          
#>  [3] "dataset.slug"            "dataset.url"            
#>  [5] "dataset.organization"    "dataset.organization_id"
#>  [7] "dataset.license"         "dataset.private"        
#>  [9] "dataset.archived"        "id"                     
#> [11] "url"                     "title"                  
#> [13] "description"             "filetype"               
#> [15] "type"                    "format"                 
#> [17] "mime"                    "filesize"               
#> [19] "checksum.type"           "checksum.value"         
#> [21] "created_at"              "modified"               
#> [23] "downloads"               "harvest.issued_at"      
#> [25] "harvest.modified_at"     "harvest.last_update"    
#> [27] "schema_name"             "schema_version"         
#> [29] "preview_url"             "extras"                 
#> [31] "annee"
```

This is an example which shows you how to access datasets which refer to
the Presidential election in 2002:

``` r
library(dplyr)
library(stringi)
ressources |> 
   mutate(dataset_title = stri_trans_general(dataset.title, "Latin-ASCII")) |> 
   filter(grepl("election presidentielle", dataset_title, ignore.case = TRUE)) |> 
   filter(annee == 2002) |> 
   select(dataset.title, downloads)
#> # A tibble: 4 × 2
#>   dataset.title                                                downloads
#>   <chr>                                                            <dbl>
#> 1 Election présidentielle 2002 – Résultats par bureaux de vote      1401
#> 2 Election présidentielle 2002 - Résultats                           395
#> 3 Election présidentielle 2002 - Résultats                           406
#> 4 Election présidentielle 2002 - Résultats                           546
```
