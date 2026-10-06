# electionsFR 0.1.1

# electionsFR 0.1.0

* Initial CRAN submission.

* Remove `download.file()` in the get_*() functions, replaced by `httr::GET()` for downloading through APIs. 

# electionsFR 0.0.2.9005

* Add `get_regionales()` function for regional elections. But, some bugs are not fixed yet.

* Add `get_senatoriales()` and `get_referendum()` functions for senate elections and referendums respectively.

# electionsFR 0.0.2.9004

* Add an extra CSV file in `inst/extdata` directory. This file is an extract of `datasets-resources.csv` original with only data about election.

* Minor changes in the name of directory in R functions for saving data.

# electionsFR 0.0.2.9003

## New features

* New function `get_europeennes()` for downloading electoral data on european elections.

* New function `get_departementales()` for downloading electoral data on department elections.

## Minor improvements and bug fixes

* Filter criterion in `get_municipales()` now includes "election metropolitaires".

* R function `download_ressources()` is now exported and available for users.

* Fix bug in the name of directory of saving downloaded files in `get_europeennes()`.

* New function `get_cantonales()` is added to `get_departementales()` as a synonymous for downloading electoral data on cantonal elections.
