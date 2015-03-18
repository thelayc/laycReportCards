#' get_absence()
#'
#' This function takes a student's report card as input (vector), and extract the number of absences
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_absence(students_list[[1]])

get_absence <- function(student_rcard){
  ## Load libraries
  library(stringr)
  
  ## Grab student's gpas
  # detect cumulative gpa element
  abs_line <- str_detect(student_rcard, "Homeroom Absences")
  # Extract element containing cumulative gpa
  student_rcard <- student_rcard[abs_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- str_replace_all(student_rcard, " ", "")
  
  ## Extract absence information
  # matches number after "Excused:"
  excused <- str_extract(student_rcard, perl("Excused:[0-9]")) 
  # Remove "Excused:"
  excused <- str_replace(excused, "Excused:", "") 
  
  # matches number after "Excused:"
  unexcused <- str_extract(student_rcard, perl("Unexcused:[0-9]+")) 
  # Remove "Excused:"
  unexcused <- str_replace(excused, "Unexcused:", "") 
  
  ## Return student's cumulative gpa
  return(list(c(abs_excused = excused, abs_unexcused = unexcused)))
}
