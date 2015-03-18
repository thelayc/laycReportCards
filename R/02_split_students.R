#' split_students()
#'
#' This function takes the output of the read_pdf() function as input, create separate report card record for each students, and returns a list of these report cards.
#' @param parsed_pdf character vector: The output of the read_pdf() function
#' @param format_type character: The report card format. DC report cards come in different formats, this argument specifies the format of the report card.
#' @keywords parsed_pdf
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' split_students(parsed_pdf)

split_students <- function(parsed_pdf, format_type = 'format2'){
  
  ## remove empty elements
  parsed_pdf <- parsed_pdf[parsed_pdf != ""]
  
  ## Identify individual student's record
  card_separator <- list(format1 = "Community Service Hours:", format2 = "SIGN AND RETURN")
  # Each student's report card ends with "Community Service Hours:" 
  txt_split <- grepl(card_separator[[format_type]], parsed_pdf, ignore.case = TRUE)
  # Identify indexes that separate each student
  txt_split <- which(txt_split == TRUE) 
  
  ## Create an empty list
  students_list <- list()
  
  # Split parsed_pdf according to txt_split indexes
  for (i in 1:length(txt_split)) {
    # Identify beginning of student's report card
    start <- ifelse(i==1, 1, txt_split[i-1])
    # Identify end of student's report card
    end <- txt_split[i]
    # Extract the student's report card information
    temp <- parsed_pdf[start:end]
    # Append the extracted information to students_list
    students_list <- c(students_list, list(temp)) 
  }
  return(students_list)
}
