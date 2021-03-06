% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bulk.R
\name{bulk_import}
\alias{bulk_import}
\alias{bulk_import.cosmos_container}
\title{Import a set of documents to an Azure Cosmos DB container}
\usage{
bulk_import(container, ...)

\method{bulk_import}{cosmos_container}(
  container,
  data,
  init_chunksize = 1000,
  verbose = TRUE,
  procname = "_AzureCosmosR_bulkImport",
  ...
)
}
\arguments{
\item{container}{A Cosmos DB container object, as obtained by \code{get_cosmos_container} or \code{create_cosmos_container}.}

\item{...}{Optional arguments passed to lower-level functions.}

\item{data}{The data to import. Can be a data frame, or a string containing JSON text.}

\item{init_chunksize}{The number of rows to import per chunk. \code{bulk_import} can adjust this number dynamically based on observed performance.}

\item{verbose}{Whether to print updates to the console as the import progresses.}

\item{procname}{The stored procedure name to use for the server-side import code. Change this if, for some reason, the default name is taken.}
}
\description{
Import a set of documents to an Azure Cosmos DB container
}
\details{
This is a convenience function to import a dataset into a container. It works by creating a stored procedure and then calling it in a loop, passing the to-be-imported data in chunks. The dataset must include a column for the container's partition key or an error will result.

Note that this function is not meant for production use. In particular, if the import fails midway through, it will not clean up after itself: you should call \code{bulk_delete} to remove the remnants of a failed import.
}
\examples{
\dontrun{

endp <- cosmos_endpoint("https://myaccount.documents.azure.com:443/", key="mykey")
db <- get_cosmos_database(endp, "mydatabase")
cont <- create_cosmos_container(db, "mycontainer", partition_key="sex")

# importing the Star Wars data from dplyr
# notice that rows with sex=NA are not imported
bulk_import(cont, dplyr::starwars)

# importing from a JSON file
writeLines(jsonlite::toJSON(dplyr::starwars), "starwars.json"
bulk_import(cont, "starwars.json")

}
}
\seealso{
\link{bulk_delete}, \link{cosmos_container}
}
