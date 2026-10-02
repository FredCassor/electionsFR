#' Download electoral data on municipal elections
#'
#' The function downloads and cleans data on local municipal elections for a specific year, aggregated by many different geographical levels.
#'
#' @param year Election year (\code{integer}).
#' @param x A data frame of datasets ressources (defaults to NULL)
#' @param encoding Data original encoding (defaults to 'UTF-8')
#' @param exdir Path to the directory
#'
#' @return None (print out the number of downloaded files)
#'
# @import dplyr
#' @import utils
# @importFrom purrr pwalk
# @importFrom rlang .data
#' @export
#'
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' get_municipales(2008)
#' }
get_municipales <- function(year, x = NULL, encoding = "UTF-8", exdir = "."){
   # Test year
   test_year_municipales(year)
   # Test encoding
   test_encoding(encoding)
   # Test external directory
   stopifnot("Invalid path for directory. Please check and try again." = identical(length(exdir), 1L))

   wdir = file.path(exdir, paste("municipales", year))
   if (!dir.exists(wdir)) dir.create(wdir)

   if (is.null(x)) {
      message("Downloading the data frame of datasets ressources...")
      x = download_ressources(encoding = encoding)
   }

   x$dataset_title = iconv(x$dataset.title, from = encoding, to = "ASCII//TRANSLIT")
   x$url_stable = paste0("https://www.data.gouv.fr/api/1/datasets/r/", x$id)
   x = x[grepl("elections municipales|elections metropolitaines",
               x$dataset_title, ignore.case = TRUE), ]
   x = x[x$annee == year, ]

   message("Downloading electoral data...")
   for (i in seq_len(nrow(x))) {
      download.file(
         url = x$url_stable[i],
         destfile = file.path(wdir, basename(x$url[i]))
      )
   }
   message(sprintf("%d files downloaded on %s.\n", nrow(x), wdir))
}
