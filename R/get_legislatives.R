#' Download electoral data on general elections
#'
#' The function downloads and cleans data on general elections for a specific year, aggregated by many different geographical levels.
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
#' @export
#'
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' get_legislatives(1997)
#' }
get_legislatives <- function(year, encoding = "UTF-8", exdir = "."){
   # Test year
   test_year_legislatives(year)
   # Test encoding
   test_encoding(encoding)
   # Test external directory
   stopifnot("Invalid path for directory. Please check and try again." = identical(length(exdir), 1L))

   wdir = file.path(exdir, paste("elections legislatives", year))
   if (!dir.exists(wdir)) dir.create(wdir)

   message("Downloading the datasets ressources...")
   df = download_ressources(encoding = encoding)

   #df$dataset_title = iconv(df$dataset.title, from = encoding, to = "ASCII//TRANSLIT")
   #df = df[grepl("elections legislatives", df$dataset_title, ignore.case = TRUE), ]
   #df = df[df$annee == year, ]
   #df$url_stable = paste0("https://www.data.gouv.fr/api/1/datasets/r/", df$id)

   df = df %>%
      dplyr::mutate(dataset_title = stringi::stri_trans_general(
         .data$dataset.title, "Latin-ASCII")) %>%
      dplyr::filter(grepl("elections legislatives", .data$dataset_title,
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
