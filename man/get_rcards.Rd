% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/get_rcards.R
\name{get_rcards}
\alias{get_rcards}
\title{get_rcards()}
\usage{
get_rcards(file, format_type = "format1")
}
\arguments{
\item{file}{The name of the file which the data are to be read from (including the .pdf extension). read_pdf that the file to be read from is in the working directory}

\item{format_type}{character: Identify the report card format that is used as input}
}
\description{
This function takes a pdf of studetns report card as input (vpdf), and returns the information in table format
}
\examples{
get_rcards('my_pdf_file.pdf')
}
\keyword{file}

