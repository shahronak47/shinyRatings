test_that("shinyRatings works", {
  expect_s3_class(shinyRatings('star'), 'shiny.tag')
  expect_s3_class(shinyRatings("star", no_of_stars = 5, default = 4), 'shiny.tag')
  expect_s3_class(shinyRatings("star", no_of_stars = 5, disabled = TRUE), 'shiny.tag')
})

test_that("ratings_html works", {
  res <- ratings_html(5, disabled = FALSE, "abc")
  expect_type(res, 'character')
  expect_s3_class(htmltools::HTML(res), 'html')
})


test_that("shinyRatings returns error", {
  expect_error(shinyRatings("star", default = 10), "default value can be greater than 0 and less than `no_of_stars`")
  expect_error(shinyRatings("star", no_of_stars = 5.86), "no_of_stars can be a whole number or a number ending with .5")
  expect_error(shinyRatings("star", default = 5.86), "default value can be a whole number or a number ending with .5")
  expect_error(shinyRatings("star", disabled = 5.86), "disabled can take only logical values")
})
