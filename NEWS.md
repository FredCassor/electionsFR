# electionsFR (development version)

* Initial CRAN submission.

# electionsFR 0.0.2.9003

## New features

* New function `get_europeennes()` for downloading electoral data on european elections.

* New function `get_departementales()` for downloading electoral data on department elections.

## Minor improvements and bug fixes

* Filter criterion in `get_municipales()` now includes "election metropolitaires".

* R function `download_ressources()` is now exported and available for users.

* Fix bug in the name of directory of saving downloaded files in `get_europeennes()`.

* New function `get_cantonales()` is added to `get_departementales()` as a synonymous for downloading electoral data on cantonal elections.
