#' Download electoral data on local departmental elections
#'
#' The function downloads and cleans data on local departmental elections for a specific year, aggregated by many different geographical levels.
#' `get_cantonales()` is equivalent to `get_departementales()`.
#'
#' @param year Election year (\code{integer}).
#' @param x A data frame of datasets ressources (defaults to NULL)
#' @param encoding Data original encoding (defaults to 'UTF-8')
#' @param exdir Path to the directory
#'
#' @return None (print out the number of downloaded files)
#'
#' @import utils
#' @importFrom httr GET write_disk progress stop_for_status
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

   wdir = file.path(exdir, paste("departementales (cantonales)", year))
   if (!dir.exists(wdir)) dir.create(wdir, recursive = TRUE)

   if (is.null(x)) {
      message("Downloading the data frame of datasets ressources...")
      x = download_resources(encoding = encoding)
   }
   #x$dataset_title = iconv(x$dataset.title, from = encoding, to = "ASCII//TRANSLIT")
   x$url_stable = paste0("https://www.data.gouv.fr/api/1/datasets/r/", x$id)
   pattern <- paste(c(paste0("elections.*departementales.*", year),
                      paste0("elections.*cantonales.*", year)),
                    collapse = "|")
   x = x[grepl(pattern, x$dataset.slug, ignore.case = TRUE), ]

   for (i in seq_len(nrow(x))) {
   #   download.file(
   #      url = x$url_stable[i],
   #      destfile = file.path(wdir, basename(x$url[i]))
   #   )
      resp <- httr::GET(x$url[i],
                        httr::write_disk(file.path(wdir, basename(x$url[i])),
                                         overwrite = TRUE),
                        httr::progress())
      httr::stop_for_status(resp)
   }
   message(sprintf("%d files downloaded on %s.\n", nrow(x), wdir))
}


#' @rdname get_departementales
#' @export
get_cantonales <- function(year, x = NULL, encoding = "UTF-8", exdir = "."){

   get_departementales(year = year, x = x, encoding = encoding, exdir = exdir)
}
