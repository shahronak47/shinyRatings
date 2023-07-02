#' Include ratings in shiny UI
#'
#' @param inputId The input slot that will be used to access the value of number of stars.
#' @param no_of_stars Number of stars that you want to display on the UI. 
#' @param default Number of stars selected by default.
#' @param disabled Keep number of stars as fixed? Disable the option of changing values
#' @return Ratings to be added to UI definition
#' @examples 
#' if(interactive()){
#'  library(shiny)
#'  library(shinyRatings)
#'
#' ui <- fluidPage(
#'   shinyRatings('star'), 
#'   textOutput('text')
#' )
#'
#' server <- function(input, output, session) {
#'    output$text <- renderText({paste("No. of stars : ", input$star)})
#' }
#'
#' shinyApp(ui, server)
#' }
#' 
#' @export
#'
shinyRatings <- function(inputId, no_of_stars = 5, default = no_of_stars, disabled = FALSE) {
  do_checks(no_of_stars, default, disabled)
  # Since in HTML 2 check box constitute of 1 star
  calculate_def <- default * 2
  htmltools::tags$html(
    htmltools::tags$head(
      htmltools::tags$link(type = "text/css", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css", rel = "stylesheet"),
      htmltools::tags$link(type = "text/css", href = "files/style.css", rel = "stylesheet"), 
      htmltools::tags$script(src="files/shinyRatingsBinding.js")
    ),
    htmltools::tags$body(
      shiny::div(id = inputId, class = "shinyRatings", 
                 htmltools::HTML(ratings_html(no_of_stars, disabled, inputId)), data = jsonlite::toJSON(list(n = calculate_def))
                )
    )
  )
}

#' @noRd
ratings_html <- function(n, disabled, inputId) {
  half_num <- seq(0.5, n, 1)
  full_num <- seq(1, n, 1)
  half_num_chr <- sub('.', '', half_num, fixed = TRUE)
  full_num_chr <- paste0(full_num, '0')
  
  dynamic_html <- paste0(
    sprintf(
      '<label aria-label="%s stars" class="rating__label rating__label--half" for="%s-%s"><i class="rating__icon--star fa fa-star-half"></i></label>
     <input class="rating__input" name="%s" id="%s-%s" value="%s" type="radio">
     <label aria-label="%s star" class="rating__label" for="%s-%s"><i class="rating__icon--star fa fa-star"></i></label>
     <input class="rating__input" name="%s" id="%s-%s" value="%s" type="radio">',
      half_num, inputId, half_num_chr, inputId, inputId, half_num_chr, half_num, full_num, inputId, full_num_chr, inputId, inputId, full_num_chr, full_num
    ), collapse = '')
  
  if(isTRUE(disabled)) {
    # Add disabled attribute to input elements
    dynamic_html <- gsub('<input', '<input disabled', dynamic_html, fixed = TRUE)
  }
  sprintf('<div class="rating-group">%s</div>', dynamic_html)
}

#' @noRd
do_checks <- function(no_of_stars, default, disabled) {
  # no_of_stars should be a whole number or should end with .5
  stopifnot("no_of_stars can be a whole number or a number ending with .5" = no_of_stars %% 1 %in% c(0, .5))
  # default value should be a whole number or should end with .5
  stopifnot("default value can be a whole number or a number ending with .5" = default %% 1 %in% c(0, .5))
  # default value should not be greater than no_of_stars
  stopifnot("default value can be greater than 0 and less than `no_of_stars`" = default > 0 && default <= no_of_stars)
  # disabled can handle only logical values
  stopifnot("disabled can take only logical values (TRUE/FALSE)" = is.logical(disabled))
}
