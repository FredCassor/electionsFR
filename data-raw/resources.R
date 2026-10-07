## code to prepare `resources` dataset goes here

datapath = system.file("extdata/extract-datasets-resources.csv", package = "electionsFR")

# Import du CSV dans la session
resources = tryCatch(
   readr::read_csv2(
      datapath,
      locale = readr::locale(encoding = "UTF-8"),
      col_types = list(
         created_at = "T", modified = "T", filesize = "d", downloads = "d",
         .default = "c")
   ),
   error = function(e) e)

# la fonction extraie le pattern recherché dans le vecteur x
extract_pattern <- function(x, pattern) {
   if (is.na(x))
      return(NA_character_)
   match <- regexpr(pattern, x)
   if (match == -1)
      return(NA_character_)
   regmatches(x, match)
}
# ajout d'une colonne type_scrutin à resources
type_scrutin <- vapply(
   resources$dataset.slug,
   extract_pattern,
   character(1),
   pattern = "legislatives|presidentielle|europeennes|municipales|metropolitaines|departementales|cantonales|regionales|referendum|senatoriales",
   USE.NAMES = FALSE
)
# Nettoyage des NAs
type_scrutin[grepl("elections.*metropole.*lyon", resources$dataset.slug)] <- "metropolitaines"
type_scrutin[grepl("election.*legislative.*partielle", resources$dataset.slug)] <- "legislatives"
resources$type_scrutin <- type_scrutin

# ajout d'une colonne correspondant à annee
annee <- vapply(resources$dataset.slug, extract_pattern, character(1),
   pattern = "[0-9]{4}", USE.NAMES = FALSE)
annee <- as.numeric(annee)
annee[annee < 1992 | annee > 3000] <- NA_integer_
resources$annee <- annee


# create the file 'resources.rda' in the data directory
usethis::use_data(resources, overwrite = TRUE)

# Documenting the data
checkhelper::fix_dataset_doc("resources")  # `use_data_doc()` was deprecated in checkhelper 1.0.0

# add the documentation into the 'man' directory
devtools::document()
