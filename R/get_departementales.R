#' Download electoral data on local departmental elections
#'
#' The function downloads and cleans data on local departmental elections for a specific year, aggregated by many different geographical levels.
#'
#' @param year Election year (\code{integer}).
#' @param x A data frame of datasets ressources (defaults to NULL)
#' @param encoding Data original encoding (defaults to 'UTF-8')
#' @param exdir Path to the directory
#'
#' @return None (print out the number of downloaded files)
#'
#' @import utils
#' @export
#'
#' @encoding UTF-8
#'
#' @examples
#' \dontrun{
#' get_departementales(2021)
#' }
get_departementales <- function(year, x = NULL, encoding = "UTF-8", exdir = "."){

   # Test year
   test_year_departementales(year)
   # Test encoding
   test_encoding(encoding)
   # Test external directory
   stopifnot("Invalid path for directory. Please check and try again." = identical(length(exdir), 1L))

   wdir = file.path(exdir, paste("election departementales (cantonales)", year))
   if (!dir.exists(wdir)) dir.create(wdir, recursive = TRUE)

   if (is.null(x)) {
      message("Downloading the data frame of datasets ressources...")
      x = download_ressources(encoding = encoding)
   }
   x$dataset_title = iconv(x$dataset.title, from = encoding, to = "ASCII//TRANSLIT")
   x$url_stable = paste0("https://www.data.gouv.fr/api/1/datasets/r/", x$id)
   x = x[grepl("elections departementales|elections cantonales",
               x$dataset_title, ignore.case = TRUE), ]
   x = x[x$annee == year, ]

   for (i in seq_len(nrow(x))) {
      download.file(
         url = x$url_stable[i],
         destfile = file.path(wdir, basename(x$url[i]))
      )
   }
   message(sprintf("%d files downloaded on %s.\n", nrow(x), wdir))
}
