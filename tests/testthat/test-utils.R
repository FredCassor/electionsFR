
# Helpers ----------------------------------------------------------------------

# file:// URL from a local path (Windows and Unix)
file_url <- function(path) {
   prefix <- if (.Platform$OS.type == "windows") "file:///" else "file://"
   paste0(prefix, normalizePath(path, winslash = "/", mustWork = FALSE))
}

# Write a small CSV in a given directory, with a given encoding
make_csv <- function(lines, dir, name = "resources.csv", encoding = "UTF-8") {
   path <- file.path(dir, name)
   txt <- paste0(paste(lines, collapse = "\n"), "\n")
   writeBin(iconv(txt, from = "UTF-8", to = encoding, toRaw = TRUE)[[1]], path)
   path
}

# Minimal resources table with the columns used by get_*().
# The ".invalid" TLD never resolves: no accidental network access.
fake_resources <- function() {
   data.frame(
      id = c("id1", "id2", "id3"),
      dataset.slug = c("elections-legislatives-2022-resultats",
                       "elections-legislatives-2017-resultats",
                       "election-presidentielle-2022"),
      url = c("https://example.org/a/res22.csv",
              "https://example.org/b/res17.csv",
              "https://example.org/c/pres22.csv"),
      stringsAsFactors = FALSE
   )
}


# Function download_resources() ----

# Test default URL works ----
test_that("download_resources works with the default URL.", {
   skip_on_cran()
   skip_if_offline()
   res <- download_resources()
   expect_s3_class(res, "data.frame")
   expect_gt(nrow(res), 0)
})

#
#test_that("download_resources retourne un data.frame avec les bonnes colonnes", {
#   csv <- tempfile(fileext = ".csv")
#   writeLines(c("dataset.title;dataset.id",
#                "Elections presidentielles 2022;a1",
#                "Autre jeu de donnees;b2"), csv)
#
#   res <- download_resources(url = file_url(csv))
#
#   expect_s3_class(res, "data.frame")
#   expect_equal(nrow(res), 2)
#   expect_true("dataset.title" %in% names(res))
#})
