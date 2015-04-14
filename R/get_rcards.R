#' get_rcards()
#'
#' This function takes a pdf of studetns report card as input (vpdf), and returns the information in table format
#' @param file The name of the file which the data are to be read from (including the .pdf extension). read_pdf that the file to be read from is in the working directory
#' @param format_type character: Identify the report card format that is used as input
#' @keywords file
#' @export
#' @examples
#' get_rcards('my_pdf_file.pdf')

get_rcards <- function(file, format_type = 'format1'){
  
  ## read pdf
  txt <- read_pdf(file)
  
  ## create separate report card record for each students
  students_list <- split_students(txt)
  
  ## Create a dataframe of names
  names <- laply(students_list, get_name)
  names <- data.frame(t(sapply(names,c)), stringsAsFactors = FALSE)
  
  ## Create a dataframe of gpas
  gpas <- laply(students_list, get_gpa)
  gpas <- data.frame(t(sapply(gpas,c)), stringsAsFactors = FALSE)
  
  ## Create a dataframe of cumulative gpas
  cumgpas <- laply(students_list, get_cumgpa)
  cumgpas <- data.frame(unlist(cumgpas), stringsAsFactors = FALSE)
  names(cumgpas) <- 'cumGpa'
  
  ## Create a dataframe of absences
  absences <- laply(students_list, get_absence)
  absences <- data.frame(t(sapply(absences,c)), stringsAsFactors = FALSE)
  
  ## Create a dataframe of grades
  grades <- laply(students_list, get_grade)
  grades <- data.frame(unlist(grades))
  names(grades) <- 'grade'
  
  ## Create a dataframe of students id
  ids <- laply(students_list, get_id)
  ids <- data.frame(unlist(ids), stringsAsFactors = FALSE)
  names(ids) <- 'school_id'
  
  ## Create a dataframe of term end's date
  dates <- laply(students_list, get_date)
  dates <- data.frame(unlist(dates), stringsAsFactors = FALSE)
  names(dates) <- 'term_date'
  
  ## Create a dataframe of community service hours
  cshours <- laply(students_list, get_cshours)
  cshours <- data.frame(unlist(cshours), stringsAsFactors = FALSE)
  names(cshours) <- 'com_service_hrs'
  
  ## Create a dataframe of topic grades
  topics <- lapply(students_list, get_grades)
  topics <- do.call("rbind.fill", topics)
  topics['value'] <- NULL
  
  ## Combine dataframes
  out <- cbind(ids, names, grades, gpas, cumgpas, absences, cshours, dates, topics)
  
  return(out)
}
