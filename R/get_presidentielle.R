#' Download electoral data on presidential election
#'
#' The function downloads and cleans data on presidential election for a specific year, aggregated by many different geographical levels.
#'
#' @param year Election year (\code{integer}).
#' @param x A data frame of datasets ressources (defaults to NULL)
#' @param encoding Data original encoding (defaults to 'UTF-8')
#' @param exdir Path to the directory
#'
#' @return None (print out the number of downloaded files)
#'
#' @import dplyr
#' @import utils
#' @importFrom purrr pwalk
#' @importFrom rlang .data
#' @importFrom httr GET write_disk progress stop_for_status
# @importFrom stringi stri_trans_general
#' @export
#'
#' @encoding UTF-8
#' @examples
#' \dontrun{
#' get_presidentielle(2002)
#' }
get_presidentielle <- function(year, x = NULL, encoding = "UTF-8", exdir = "."){
   # Test year
   test_year_presidentielle(year)
   # Test encoding
   test_encoding(encoding)
   # Test external directory
   stopifnot("Invalid path for directory. Please check and try again." = identical(length(exdir), 1L))

   wdir = file.path(exdir, paste("presidentielle", year))
   if (!dir.exists(wdir)) dir.create(wdir)

   if (is.null(x)) {
      message("Downloading the data frame of datasets resources...")
      x = download_ressources(encoding = encoding)
   }

   x = x %>%
   #   dplyr::mutate(dataset_title = stringi::stri_trans_general(
   #      .data$dataset.title, "Latin-ASCII")) %>%
      dplyr::filter(grepl("election.*presidentielle", .data$dataset.slug)) %>%
      dplyr::filter(.data$annee == year) %>%
      dplyr::mutate(url_stable = paste0("https://www.data.gouv.fr/api/1/datasets/r/",
                                        .data$id))

   message("Downloading electoral data...")
   #x %>%
   #   dplyr::select(x = .data$url, y = url) %>%
   #   purrr::pwalk(function(x, y) {
   #      download.file(url = x,
   #                    destfile = file.path(wdir, basename(y)), mode = "wb")
   #   })
   for (i in seq_len(nrow(x))) {
      resp <- httr::GET(x$url[i],
                       httr::write_disk(file.path(wdir, basename(x$url[i])), overwrite = TRUE),
                       httr::progress()
                       )
      httr::stop_for_status(resp)
   }
   message(sprintf("%d files downloaded on %s.\n", nrow(x), wdir))
}
