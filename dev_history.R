usethis::use_build_ignore("dev_history.R")

desc::desc_set(Title = "R Functions to Download French Electoral Data")
desc::desc_set(Description = "Offers a set of functions to easily download and clean French electoral data from the public archive data-gouv.fr.")

usethis::use_gpl3_license()

desc::desc_set(Language = "fr")

attachment::att_amend_desc()
devtools::check()
