## code to prepare `ressources` dataset goes here

# datapath = system.file("data-raw/datasets-resources.csv", package = "electionFR")
datapath = paste0(tempdir(), "/datasets-resources.csv")

if (file.exists(datapath)) {
   ressources = tryCatch(readr::read_csv2(datapath,
                                          locale = readr::locale(encoding = "UTF-8")),
            error = function(e) e)
   ressources = ressources |>
   #   dplyr::mutate(.data$annee = stringr::str_extract(.data$dataset.title, "[0-9]{4}")) |>
   #   dplyr::mutate(.data$annee = readr::parse_number(.data$annee))
      dplyr::mutate(annee = stringr::str_extract(dataset.title, "[0-9]{4}")) |>
      dplyr::mutate(annee = readr::parse_number(annee))
}

# create the file 'ressources.rda' in the data directory
usethis::use_data(ressources, overwrite = TRUE)

# Documenting the data
checkhelper::fix_dataset_doc("ressources")  # `use_data_doc()` was deprecated in checkhelper 1.0.0

# add the documentation into the 'man' directory
devtools::document()
