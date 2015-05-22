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
  
  # 1 - Extract lines containing absence information
  # detect cumulative gpa element
  abs_line <- stringr::str_detect(student_rcard, "Homeroom Absences")
  # CHECK that pattern has been matched
  assertthat::assert_that(sum(abs_line) > 0)
  # Extract element containing cumulative gpa
  student_rcard <- student_rcard[abs_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- stringr::str_replace_all(student_rcard, " ", "")
  
  # 2 - Extract absence information
  # CHECK: If there is a match for "Excused:"
  assertthat::assert_that(sum(grepl(pattern = 'Excused:', x = student_rcard)) > 0)
  # matches number after "Excused:"
  excused <- stringr::str_extract(student_rcard, stringr::regex("Excused:[0-9]")) 
  # Remove "Excused:"
  excused <- stringr::str_replace(excused, "Excused:", "") 
  
  # CHECK: If there is a match for "Unexcused:"
  assertthat::assert_that(sum(grepl(pattern = 'Unexcused:', x = student_rcard)) > 0)
  # matches number after "Unexcused:"
  unexcused <- stringr::str_extract(student_rcard, stringr::regex("Unexcused:[0-9]+")) 
  # Remove "Excused:"
  unexcused <- stringr::str_replace(excused, "Unexcused:", "") 
  
  ## Return student's cumulative gpa
  return(list(c(abs_excused = excused, abs_unexcused = unexcused)))
}
