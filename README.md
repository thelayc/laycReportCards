### TO DO on master branch
* 11_get_grades(): Improve code -> many repetitions
* Figure out how to insert grades in the final dataset.
  - Now return a 1xn(i) dataframe for student (i).
  - Problem is: different students have different columns
  - Need to figure out how to merge individual dataframe into one big dataframe
  - And then how to add that dataframe to the main dataframe returned by get_rcards()

### TO DO on format2 branch
* read_pdf(): Include test that checks OS type: Windows, Mac, Linux
* split_student(): Add documentation about the different types of report cards
* 11_get_grades: review issue with reshape and reshape2