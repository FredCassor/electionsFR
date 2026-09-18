# See https://electionsbr.com/novo/ for help.

#' Download data ressources on the French Ministry of the Interior's datasets
#'
#' \code{get_ressources()} downloads a file with references on datasets available on the public archive. The function returns data frame where each observation corresponds to a data ressource type.
#'
#' @param url Url where to get datasets ressources
#' @param encoding Data original encoding (defaults to 'utf-8')
#' @param dest_dir Path or directory of downloaded file
#'
#' @return a data frame
#'
#' @importFrom readr read_csv2
#' @importFrom utils download.file
#' @export
#'
#' @examples
#' \dontrun{
#' df <- get_ressources()
#' }
get_ressources = function(url = NULL, encoding = "UTF-8", dest_dir = "data-raw") {

   # test
   stopifnot(
      identical(length(encoding), 1L),
      identical(length(dest_dir), 1L)
   )

   # URL
   if (is.null(url)) {
      url = "https://www.data.gouv.fr/fr/organizations/ministere-de-l-interieur/datasets-resources.csv"
   }

   # Directory and file path
   if (!dir.exists(dest_dir)) dir.create(dest_dir, recursive = TRUE)
   full_file_name = paste0(dest_dir,"/", basename(url))

   download.file(url, full_file_name)
   data = readr::read_csv2(full_file_name,
                           locale = readr::locale(encoding = encoding),
                           col_types = readr::cols()
   )
   data
}
# df = get_ressources()
