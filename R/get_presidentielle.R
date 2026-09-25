#' Get data on presidential election
#'
#' \code{get_presidentielle} downloads and cleans data on presidential election for a specific year, aggregated by many different geographical levels.
#'
#' @param year Election year (\code{integer}).
#' @param encoding Data original encoding (defaults to 'UTF-8')
#' @param exdir Path to the directory
#'
#' @return None (print out the number of downloaded files)
#'
#' @import dplyr
#' @import utils
#' @importFrom purrr pwalk
#' @importFrom rlang .data
#' @importFrom stringi stri_trans_general
#' @export
#'
#' @encoding UTF-8
#' @examples
#' \dontrun{
#' get_presidentielle(2002)
#' }
get_presidentielle = function(year, encoding = "UTF-8", exdir = "."){
   wdir = file.path(exdir, paste("election presidentielle", year))
   if (!dir.exists(wdir)) dir.create(wdir)
   #setwd(wdir)

   message("Downloading the datasets ressources...")
   df = download_ressources(encoding = encoding)

   df = df %>%
      dplyr::mutate(dataset_title = stringi::stri_trans_general(
         .data$dataset.title, "Latin-ASCII")) %>%
      dplyr::filter(grepl("election presidentielle", .data$dataset_title,
                          ignore.case = TRUE)) %>%
      dplyr::filter(.data$annee == year) %>%
      dplyr::mutate(url_stable = paste0("https://www.data.gouv.fr/api/1/datasets/r/",
                                        .data$id))

   message("Downloading data...")
   df %>%
      dplyr::select(x = .data$url_stable, y = url) %>%
      purrr::pwalk(\(x, y) {
         download.file(url = x,
                       destfile = file.path(wdir, basename(y))
         )
      })
   message(sprintf("%d files downloaded on %s.\n", nrow(df), wdir))
}
