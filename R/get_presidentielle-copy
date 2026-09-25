#' Get data on presidential election
#'
#' \code{get_presidentielle} downloads and cleans data on presidential election for a specific year, aggregated by many different geographical levels.
#'
#' @param data a data frame.
#' @param year Election year (\code{integer}).
#'
#' @return None (print out the number of downloaded files)
#'
#' @import dplyr
#' @importFrom purrr pwalk
#' @importFrom rlang .data
#' @importFrom stringi stri_trans_general
#' @export
#'
#' @encoding UTF-8
#' @examples
#' \dontrun{
#' data("ressources")
#' get_presidentielle(ressources, 2002)
#' }
get_presidentielle = function(data, year){
   wdir = paste("data-raw/presidentielle", year)
   if (!dir.exists(wdir)) dir.create(wdir)
   df = data |>
      dplyr::mutate(dataset_title = stringi::stri_trans_general(
         .data$dataset.title, "Latin-ASCII")) |>
      dplyr::filter(grepl("election presidentielle", .data$dataset_title,
                          ignore.case = TRUE)) |>
      dplyr::filter(.data$annee == year) |>
      dplyr::mutate(url_stable = paste0("https://www.data.gouv.fr/api/1/datasets/r/",
                                        .data$id))
   df |>
      dplyr::select(x = .data$url_stable, y = url) |>
      purrr::pwalk(\(x, y) {
         download.file(url = x,
                       destfile = file.path(wdir, basename(y))
         )
      })
   message(paste(nrow(df), "files downloaded."))
}
