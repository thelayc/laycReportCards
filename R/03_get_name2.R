#' get_name2()
#'
#' This function takes a student's report card as input (vector), and extract the students first and last name.
#' @param student_rcard A vector containing a student's report card information
#' @param format_type character: The report card format. DC report cards come in different formats, this argument specifies the format of the report card.
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_name(students_list[[1]])
#' [[1]]
#' [1] "First name" "Last name" 

get_name2 <- function(student_rcard, format_type){
  
  # 1 - Extract lines containing name information
  # Identify students' separator element
  name_separator <- list(students_progress = "Student Name:", report_card = "Parent or guardian of")
  # detect student's name element
  name_line <- grep(pattern = name_separator[[format_type]], x = student_rcard)
  # CHECK that pattern has been matched
  assertthat::assert_that(length(name_line) == 1)
  # Extract element containing student's name
  student_rcard <- student_rcard[name_line + 1]
  # Remove potential duplicates
  student_rcard <- student_rcard[1]
  
  # 2 - Extract first and last names
  # Code for students_progress format
  if (format_type == 'students_progress') {
    
    # Extract first name
    # matches everything after the comma & space, and before the first space
    first_name <- stringr::str_extract(student_rcard, stringr::regex("(, )[A-Z][a-z]+()"))
    # matches only letters in the string
    first_name <- stringr::str_extract(first_name, stringr::regex("[A-Z][a-z]+"))
    
    # Extract last name
    # matches everything before the first comma and the first space before the comma.
    last_name <- stringr::str_extract(student_rcard, stringr::regex("\\S+(?=\\,)"))
    
    # Code for report_card format
  } else {
    
    # Extract first name
    # matches everything after the comma & space, and before the first space
    first_name <- stringr::str_extract(student_rcard, 
                                       stringr::regex("[A-Z][a-z]+()"))
    # matches only letters in the string
    first_name <- stringr::str_extract(first_name, 
                                       stringr::regex("[A-Z][a-z]+"))
    
    # Extract last name
    # matches everything before the first comma and the first space before the comma.
    last_name <- stringr::str_extract(student_rcard, 
                                      stringr::regex("[ ].+$"))
    last_name <- stringr::str_trim(last_name)
    
  }
  
  # CHECK: First and Last name should contain only alphabetic characters
  assertthat::assert_that(grepl(pattern = '[^[:alpha:]]', x = first_name) == FALSE)
  #assertthat::assert_that(grepl(pattern = '[^[:alpha:]]', x = last_name) == FALSE)
  
  # 3 - Return student's name
  return(list(c(fname = first_name, lname = last_name)))
}
