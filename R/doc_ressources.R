#' ressources
#'
#' The data found in the French Ministry of the Interior's public data archive datagouv.
#'
#' @docType data
#' @keywords dataset
#'
#' @format
#' A data frame with 30 columns. Each row represents a single dataset:
#' \describe{
#'    \item{dataset.id}{Dataset identifier}
#'    \item{dataset.title}{Title of the dataset collection}
#'    \item{dataset.slug}{}
#'    \item{dataset.url}{URL of the dataset collection}
#'    \item{dataset.organization}{Name of the dataset producer}
#'    \item{dataset.organization_id}{Dataset producer identifier}
#'    \item{dataset.license}{Type of license}
#'    \item{dataset.private}{Whether that dataset is private}
#'    \item{dataset.archived}{}
#'    \item{id}{Dataset identifier}
#'    \item{url}{URL of the dataset}
#'    \item{title}{Title of the dataset}
#'    \item{description}{General description of the dataset}
#'    \item{filetype}{Type of the file}
#'    \item{type}{}
#'    \item{format}{Format of the file}
#'    \item{mime}{file extension (test/csv)}
#'    \item{filesize}{Size of the file}
#'    \item{checksum.type}{Check sum}
#'    \item{checksum.value}{Check sum value}
#'    \item{created_at}{Date of creation}
#'    \item{modified}{Date of last modification}
#'    \item{downloads}{Number of downloads}
#'    \item{harvest.issued_at}{}
#'    \item{harvest.modified_at}{}
#'    \item{harvest.last_update}{}
#'    \item{schema_name}{}
#'    \item{schema_version}{}
#'    \item{preview_url}{}
#'    \item{extras}{}
#'    \item{annee}{Reference year}
#' }
#' @source
#' * \url{https://www.data.gouv.fr/fr/organizations/ministere-de-l-interieur/}
"ressources"
