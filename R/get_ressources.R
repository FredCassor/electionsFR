# See https://electionsbr.com/novo/ for help.

#' Download data ressources on the French Ministry of the Interior's datasets
#'
#' The function downloads a file with references on datasets available on the public archive. The function returns data frame where each observation corresponds to a data ressource type.
#'
#' @param encoding Data original encoding (defaults to 'UTF-8')
#'
#' @return a data frame
#'
#' @importFrom readr read_csv2
#' @importFrom utils download.file
#' @importFrom stringr str_extract
#' @importFrom rlang .data
#' @import dplyr
#' @export
#'
#' @examples
#' \dontrun{
#' df <- get_ressources()
#' }
get_ressources = function(encoding = "UTF-8") {

   # test
   stopifnot(
      identical(length(encoding), 1L)
   )

   # URL
   url = "https://www.data.gouv.fr/fr/organizations/ministere-de-l-interieur/datasets-resources.csv"

   # Directory and file path
   temp_dir = tempdir()
   full_file_name = paste0(temp_dir,"/", basename(url))

   message("Downloading the ressources data...")
   download.file(url, full_file_name)
   message("Done.\n")

   data = readr::read_csv2(full_file_name,
                           locale = readr::locale(encoding = encoding),
                           col_types = readr::cols())
   message("The ressources data were downloaded to this directory: ", temp_dir,"\n")
   data = data %>%
      dplyr::mutate(annee = stringr::str_extract(.data$dataset.title, "[0-9]{4}")) %>%
      dplyr::mutate(annee = readr::parse_number(.data$annee))
   data
}
