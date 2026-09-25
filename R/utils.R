
#' Download and clean the datasets ressources of MI
#'
#' @param encoding Data original encoding (defaults to 'UTF-8')
#'
#' @return a data frame
#'
#' @import dplyr
#' @importFrom utils download.file
#' @importFrom rlang .data
#' @importFrom stringr str_extract
download_ressources = function(encoding = "UTF-8") {

   # URL
   url = "https://www.data.gouv.fr/fr/organizations/ministere-de-l-interieur/datasets-resources.csv"

   # Set the directory and file path
   temp_dir = tempdir()
   full_file_name = basename(url)
   temp_file_name = paste0(temp_dir,"/", basename(url))

   download.file(url, temp_file_name)
   message("The ressources data were downloaded on ", temp_dir,"\n")

   data = suppressWarnings(readr::read_csv2(temp_file_name,
                           locale = readr::locale(encoding = encoding),
                           col_types = readr::cols(),
                           progress = F))
   data = data  %>%
      dplyr::mutate(annee = stringr::str_extract(.data$dataset.title, "[0-9]{4}"))  %>%
      dplyr::mutate(annee = readr::parse_number(.data$annee))
   data
}
