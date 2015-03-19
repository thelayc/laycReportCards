#' read_pdf()
#'
#' This function takes a DC report card (pdf) as input, reads its content and output this content as text
#' @param file The name of the file which the data are to be read from (including the .pdf extension). read_pdf that the file to be read from is in the working directory
#' @param xpdf_options Specify options for pdftotext software. Refer to http://linux.die.net/man/1/pdftotext for the full list of available options.
#' @keywords my_function
#' @export
#' @examples
#' read_pdf('my_pdf_file.pdf')

read_pdf <- function(file, xpdf_options = '-table -eol dos'){
  ## build path to pdf file
  path <- paste0(getwd(), '/', file)
  
  ## Check that to pdftotxt.exe has been installed
#   exe_version <- 'xpdfbin-win-3.04'
#   if (file.exists(paste0(C:/Program Files (x86)/xpdfbin-win-3.04/bin64/pdftotext.exe)))
  ## set path to pdftotxt.exe
  # Deal with path difference on 32 vs 64 bits version of Windows
  if (file.exists("C:/Program Files (x86)")){
  exe <- "C:/Program Files (x86)/xpdfbin-win-3.04/bin64/pdftotext.exe"
  } else {
    exe <- "C:/Program Files/xpdfbin-win-3.04/bin32/pdftotext.exe"
  }
  ## Convert pdf to text with pdftotext
  system(paste("\"", exe, "\" ", xpdf_options, " \"", path, "\"", sep = ""), wait = TRUE)
  
  ## get txt-file name and open it
  filetxt <- sub(".pdf", ".txt", file)
  
  ## read filetxt and store it as a vector
  readLines(filetxt, warn = FALSE)
}