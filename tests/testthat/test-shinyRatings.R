test_that("shinyRatings works", {
  expect_s3_class(shinyRatings('star'), 'shiny.tag')
})

test_that("ratings_html works", {
  res <- ratings_html()
  expect_type(res, 'character')
  expect_s3_class(htmltools::HTML(res), 'html')
})
