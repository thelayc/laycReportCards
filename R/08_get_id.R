#' get_id()
#'
#' This function takes a student's report card as input (vector), and extract the student's id
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_id(students_list[[1]])

get_id <- function(student_rcard){
  
  # 1 - Extract lines containing student's ID information
  # detect cumulative gpa element
  id_line <- stringr::str_detect(student_rcard, "Student ID:")
  # CHECK: that pattern has been matched
  assertthat::assert_that(sum(id_line) > 0)
  # Extract element containing cumulative gpa
  student_rcard <- student_rcard[id_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- stringr::str_replace_all(student_rcard, " ", "")
  
  # 2 - Extract ID
  # matches numbers after "StudentID"
  id <- stringr::str_extract(student_rcard, stringr::regex("StudentID:[0-9]+")) 
  # Remove "Cumulative="
  id <- stringr::str_replace(id, "StudentID:", "") 
  
  ## Return student's cumulative gpa
  return(list(c(id = id)))
}
