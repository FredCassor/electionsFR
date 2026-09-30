
#' Download and clean the datasets ressources of MI
#'
#' @param encoding Data original encoding (defaults to 'UTF-8')
#'
#' @return a data frame
#'
#' @import dplyr
#' @importFrom utils download.file
#' @importFrom rlang .data
# @importFrom stringr str_extract
download_ressources = function(encoding = "UTF-8") {

   # URL
   url = "https://www.data.gouv.fr/fr/organizations/ministere-de-l-interieur/datasets-resources.csv"

   # Set the directory and file path
   temp_dir = tempdir()
   full_file_name = basename(url)
   temp_file_name = file.path(temp_dir, basename(url))

   download.file(url, temp_file_name)
   message("The ressources data were downloaded on :", temp_dir)

   data = suppressWarnings(readr::read_csv2(temp_file_name,
                           locale = readr::locale(encoding = encoding),
                           col_types = readr::cols(),
                           progress = F))
   data = data  %>%
      dplyr::mutate(annee = stringr::str_extract(.data$dataset.title, "[0-9]{4}"))  %>%
      dplyr::mutate(annee = readr::parse_number(.data$annee))
   #data$annee <- NA_character_
   #pos_annee <- regexpr("[0-9]{4}", data$dataset.title)
   #a_match <- pos_annee != -1  # indice des correspondances trouvées
   #data$annee[a_match] <- regmatches(data$dataset.title[a_match], pos_annee[a_match])
   #data$annee <- as.numeric(data$annee)
   data
}

# Tests election year inputs
test_year_presidentielle <- function(year){

   if(!is.numeric(year) | !length(year)==1 | !year %in% c(1995, 2002, 2007, 2012, 2017, 2022, 2027))
      stop("Invalid input for year. Please check the documentation and try again.")
}

# Tests election year inputs
test_year_legislatives <- function(year){

   if(!is.numeric(year) | !length(year)==1 | !year %in% c(
      1993,1997,2002,2007,2012,2016,2017,2022,2024,2027
   ))
      stop("Invalid input for year. Please check the documentation and try again.")
}

# Tests election year inputs
test_year_municipales <- function(year){

   if(!is.numeric(year) | !length(year)==1 | !year %in% c(2001,2008,2014,2015,2020,2026))
      stop("Invalid input for year. Please check the documentation and try again.")
}

# Tests election year inputs
test_year_europeennes <- function(year){

   if(!is.numeric(year) | !length(year)==1 | !year %in% c(1994,1999,2004,2009,
                                                          2014,2019,2024))
      stop("Invalid input for year. Please check the documentation and try again.")
}

# Tests election year inputs
test_year_regionales <- function(year){

   if(!is.numeric(year) | !length(year)==1 | !year %in% c(1998,2004,2010,2015,
                                                          2021))
      stop("Invalid input for year. Please check the documentation and try again.")
}

# Tests election year inputs
test_year_departementales <- function(year){

   if(!is.numeric(year) | !length(year)==1 | !year %in% c(1992,1994,1998,2001,
                                                          2004,2008,2011,2015,
                                                          2021))
      stop("Invalid input for year. Please check the documentation and try again.")
}

# Tests election year inputs
test_year_senatoriales <- function(year){

   if(!is.numeric(year) | !length(year)==1 | !year %in% c(1992,1995,1998,2001,
                                                          2004,2008,2011,2014,
                                                          2015,2017,2023,2026))
      stop("Invalid input for year. Please check the documentation and try again.")
}


# Tests electoral data encoding inputs
test_encoding <- function(encoding){

   encoding = tolower(encoding)
   if (!length(encoding)==1 | !encoding %in% tolower(iconvlist()))
      stop("Invalid input for encoding. Check iconvlist() to view a list with all valid encodings.")
}
