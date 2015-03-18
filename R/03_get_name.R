#' get_name()
#'
#' This function takes a student's report card as input (vector), and extract the students first and last name.
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_name(students_list[[1]])
#' [[1]]
#' [1] "First name" "Last name" 

get_name <- function(student_rcard, format_type){
  
  ## Grab student's name
  name_separator <- list(format1 = "Student Name:", format2 = "Parent or guardian of")
  # detect student's name element
  name_line <- stringr::str_detect(student_rcard, name_separator[[format_type]])
  
  if (format_type == 'format1') {
    # Extract element containing student's name
    student_rcard <- student_rcard[name_line]
    # Remove potential duplicates
    student_rcard <- student_rcard[1]
    
    
    # Extract first name
    # matches everything after the comma & space, and before the first space
    first_name <- stringr::str_extract(student_rcard, perl("(, )[A-Z][a-z]+()"))
    # matches only letters in the string
    first_name <- stringr::str_extract(first_name, perl("[A-Z][a-z]+"))
    
    # Extract last name
    # matches everything before the first comma and the first space before the comma.
    last_name <- stringr::str_extract(student_rcard, perl("\\S+(?=\\,)"))
    
  } else {
    # Extract element containing student's name
    student_rcard <- student_rcard[name_line]
    # Remove potential duplicates
    student_rcard <- student_rcard[1]
    
    
    # Extract first name
    # matches everything after the comma & space, and before the first space
    first_name <- stringr::str_extract(student_rcard, perl("(, )[A-Z][a-z]+()"))
    # matches only letters in the string
    first_name <- stringr::str_extract(first_name, perl("[A-Z][a-z]+"))
    
    # Extract last name
    # matches everything before the first comma and the first space before the comma.
    last_name <- stringr::str_extract(student_rcard, perl("\\S+(?=\\,)"))
    
  }
  
  ## Return student's name
  return(list(c(fname = first_name, lname = last_name)))
}
