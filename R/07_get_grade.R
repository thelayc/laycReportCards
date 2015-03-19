#' get_grade()
#'
#' This function takes a student's report card as input (vector), and extract the student's grade level.
#' 
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_grade(students_list[[1]])

get_grade <- function(student_rcard){
  
  #1) Identify line(s) with student's grade level
  # detect grade level element
  grade_line <- stringr::str_detect(student_rcard, "Grade:")
  # Extract line containing grade level
  student_rcard <- student_rcard[grade_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- stringr::str_replace_all(student_rcard, " ", "")
  
  #2) Extract grade level
  # Detect grade level information in the line
  grade <- stringr::str_extract(student_rcard, stringr::perl("Grade:[0-9]+")) 
  # Remove extra information
  grade <- stringr::str_replace(grade, "Grade:", "") 
  
  ## Return student's grade level
  return(list(c(grade = grade)))
}
