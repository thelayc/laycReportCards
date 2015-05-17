library(laycReportCards)
context("pdftotext installed")

test_that("pdftotxt is installed on computer", {
  expect_true(file.exists('C:/Program Files (x86)/xpdfbin-win-3.04/bin64/pdftotext.exe')|
                file.exists('C:/Program Files/xpdfbin-win-3.04/bin32/pdftotext.exe'), 
              info = 'In order to use this package, please download and install pdftotxt (http://www.foolabs.com/xpdf/download.html)')
  
})