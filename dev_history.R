usethis::use_build_ignore("dev_history.R")

desc::desc_set(Title = "R Functions to Download French Electoral Data")
desc::desc_set(Description = "This package offers a set of functions to easily download and clean French electoral data from the public archive data-gouv.fr.")

usethis::use_gpl3_license()

desc::desc_set(Language = "fr")

attachment::att_amend_desc()
devtools::check()

usethis::use_git()
usethis::use_github(organisation = NULL)

usethis::use_readme_rmd()
devtools::build_readme()

devtools::load_all()

usethis::use_data_raw("ressources")

usethis::use_r("get_ressources")
usethis::use_r("get_presidentielle")

usethis::use_package("dplyr")
usethis::use_package("readr")
usethis::use_package("stringr")
usethis::use_package("stringi")
usethis::use_package("purrr")
