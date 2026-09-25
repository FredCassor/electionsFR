# exclusion du dev_history du scope du package en cours
usethis::use_build_ignore("dev_history.R")
# Modification du titre et de la description du package
desc::desc_set(Title = "R Functions to Download French Electoral Data")
desc::desc_set(Description = "This package offers a set of functions to easily download and clean French electoral data from the public archive data-gouv.fr.")
# Gestion de la licence (GPL3)
usethis::use_gpl3_license()
# Gestion de la langue du package
desc::desc_set(Language = "fr")
# Modification de la documentation et check du package
attachment::att_amend_desc()
devtools::check()
# Installation du controle de version du package via Git et GitHub
usethis::use_git()
usethis::use_github(organisation = NULL)
# Modification du README
usethis::use_readme_rmd()
devtools::build_readme()
# Chargement du package
devtools::load_all()
# Ajout d'une fonction utils.R dans R/
usethis::use_r("utils")
# Gestion d'un fichier data dans data-raw/
usethis::use_data_raw("ressources")

usethis::use_version()
# Ajout des fonctions dans R/
usethis::use_r("get_ressources")
usethis::use_r("get_presidentielle")
# Ajout des packages externes dans la documentation
usethis::use_package("dplyr")
usethis::use_package("readr")
usethis::use_package("stringr")
usethis::use_package("stringi")
usethis::use_package("purrr")

usethis::use_r("get_legislatives")
