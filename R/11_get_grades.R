#' get_grades()
#'
#' This function takes a student's report card as input (vector), and extract the student's grades and courses.
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' student_rcard <- students_list[[1]]
#' get_grades(student_rcard)

get_grades <- function(student_rcard){
  
  #1) Identify grades alignment on the page
  # Detect line that starts with "Course"
  course_line <- stringr::str_detect(student_rcard, '^Course')
  # Extract lines starting with "Course"
  course <- student_rcard[course_line]
  # Remove potential duplicates
  course <- course[1]
  # Locate the starting position of "Sec" in the string
  sec_position <- stringr::str_locate(course, 'Sec')[1]
  
  #2) Detect lines with grades information
  grade_lines <- stringr::str_detect(substr(student_rcard, sec_position, sec_position + 2), '^[0-9]{2}')
  # Extract grade lines
  grade_lines <- student_rcard[grade_lines]
  
  #3) Identify position of each grade on the line
   # Use "Term 1", "Term 2", ..., "Exam", and "Final" as position markers
  # detect where grades information begins
  term_line <- stringr::str_detect(student_rcard, "Term 1")
  # Extract element containing Term 1"
  term <- student_rcard[term_line]
  # Remove potential duplicates
  term <- term[1]
  # Locate the starting position of "Term 1" in the string
  g1_position <- stringr::str_locate(term, 'Term 1')[1]
  # Locate the starting position of "Term 2" in the string
  g2_position <- stringr::str_locate(term, 'Term 2')[1]
  # Locate the starting position of "Term 3" in the string
  g3_position <- stringr::str_locate(term, 'Term 3')[1]
  # Locate the starting position of "Term 4" in the string
  g4_position <- stringr::str_locate(term, 'Term 4')[1]
  # Locate the starting position of "Exam" in the string
  exam_position <- stringr::str_locate(term, 'Exam')[1]
  # Locate the starting position of "Term 4" in the string
  final_position <- stringr::str_locate(term, 'Final')[1]
  
  #4) Grab grades based on the position information
  # grab course names
  courses <- stringr::str_trim(substr(grade_lines, sec_position + 5, g1_position - 1))
  # grab grades from term 1
  term1 <- stringr::str_trim(substr(grade_lines, g1_position, g2_position - 1))
  # grab grades from term 2
  term2 <- stringr::str_trim(substr(grade_lines, g2_position, g3_position - 1))
  # grab grades from term 3
  term3 <- stringr::str_trim(substr(grade_lines, g3_position, g4_position - 1))
  # grab grades from term 4
  term4 <- stringr::str_trim(substr(grade_lines, g4_position, exam_position - 1))
  # grab grades from exam
  exam <- stringr::str_trim(substr(grade_lines, exam_position, final_position - 1))
  # grab grades from final
  final <- stringr::str_trim(substr(grade_lines, final_position, final_position + 10))
  
  # Create a dataframe
  grades <- data.frame(courses = courses, term1 = term1, term2 = term2, term3 = term3, term4 = term4, exam = exam, final = final)
  # Remove extra rows
  keep <- !grepl(pattern = '^Authorized', x = grades$courses)
  grades <- grades[keep, ]
  # Replace blank by NAs: TO BE DONE
  
  # Melt data frame
  grades <- reshape2::melt(grades, id = c('courses'))
  # Remove rows with empty value
  grades$value <- stringr::str_replace_all(grades$value, " ", "")
  # Make wide
  grades <- reshape::cast(grades, ~ courses + variable)
  
  return(grades)
}
