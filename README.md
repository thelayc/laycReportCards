### TO DO on master branch
* Get consistent with function calls between base & 
* 11_get_grades(): Improve code -> many repetitions
* Figure out how to insert grades in the final dataset.
  - Now return a 1xn(i) dataframe for student (i).
  - Problem is: different students have different columns
  - Need to figure out how to merge individual dataframe into one big dataframe
  - And then how to add that dataframe to the main dataframe returned by get_rcards()
* read_pdf: check the version of pdftotext
* get_name: create separate functions to extract name depending on format
* get_name: replace if/else by function? See shiny tutorial
* get_gpa: simplify quarterly gpa extraction -> Many repetition

<<<<<<< HEAD
### TO DO on format2 branch
=======
### TO DO on format2 branch
* read_pdf(): Include test that checks OS type: Windows, Mac, Linux
* split_student(): Add documentation about the different types of report cards
* 11_get_grades: review issue with reshape and reshape2
>>>>>>> format2
