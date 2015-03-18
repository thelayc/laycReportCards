#' get_date()
#'
#' This function takes a student's report card as input (vector), and extract the term end's date
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_date(students_list[[1]])

get_date <- function(student_rcard){
  ## Load libraries
  library(stringr)
  
  ## Grab student's gpas
  # detect cumulative gpa element
  date_line <- str_detect(student_rcard, "For Term Ending on:")
  # Extract element containing cumulative gpa
  student_rcard <- student_rcard[date_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- str_replace_all(student_rcard, " ", "")
  
  ## Extract cumulative gpa
  # matches number with format 0.00 after "Cumulative="
  date <- str_extract(student_rcard, perl("ForTermEndingon:.+")) 
  # Remove "Cumulative="
  date <- str_replace(date, "ForTermEndingon:", "") 
  
  ## Return student's cumulative gpa
  return(list(c(date = date)))
}
