list.files('../temp_data', full.names = TRUE, recursive = TRUE)
txt <- read_pdf('../temp_data/report_cards/Powell ES Term2 report cards SY14-15.pdf')
rcards <- split_students(txt)
rcards[[1]]
l <- rcards[[1]][10]
nchar(l)
for (i in 1:nchar(l)) {
  print(paste(i, substr(l, 1, i)))
}

#########################################
parsed_pdf <-read_pdf('./data/wilson_20140124.pdf')
students_list <- split_students(parsed_pdf)
student_rcard <- students_list[[2]]

test <- get_grades(student_rcard)

test <- test[test$courses != 'Authorized PM Off Campus', ]
test[] <- lapply(test, function(x) {ifelse(x == "", NA, as.character(x))})

lapply(mtcars, function(x) length(unique(x)))


student_rcard <- report_cards[[2]]

test <- get_rcards('./data/report_card.pdf')
