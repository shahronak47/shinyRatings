#' Include ratings in shiny UI
#'
#' @param inputId The input slot that will be used to access the value of number of stars.
#' @param no_of_stars Number of stars that you want to display on the UI. 
#'
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
shinyRatings <- function(inputId, no_of_stars = 5) {
  initialise_value(session, inputId, no_of_stars)
  htmltools::tags$html(
    htmltools::tags$head(
      htmltools::tags$link(type = "text/css", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css", rel = "stylesheet"),
      htmltools::tags$link(type = "text/css", href = "files/style.css", rel = "stylesheet"), 
      htmltools::tags$script(src="files/shinyRatingsBinding.js"),
    ),
    htmltools::tags$body(
      shiny::div(id = inputId, class = "shinyRatings", 
                 htmltools::HTML(ratings_html(no_of_stars))
                )
    )
  )
}

#' @noRd
ratings_html <- function(n) {
  half_num <- seq(0.5, n, 1)
  full_num <- seq(1, n, 1)
  half_num_chr <- sub('.', '', half_num, fixed = TRUE)
  full_num_chr <- paste0(full_num, '0')
  
  dynamic_html <-  paste0(
    sprintf(
      '<label aria-label="%s stars" class="rating__label rating__label--half" for="rating2-%s"><i class="rating__icon rating__icon--star fa fa-star-half"></i></label>
<input class="rating__input" name="rating2" id="rating2-%s" value="%s" type="radio">
<label aria-label="%s star" class="rating__label" for="rating2-%s"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
<input class="rating__input" name="rating2" id="rating2-%s" value="%s" type="radio">', 
      half_num, half_num_chr, half_num_chr, half_num, full_num, full_num_chr, full_num_chr, full_num
    ), collapse = '')
  
  sprintf('<div class="rating-group">%s</div>', dynamic_html)
}

#' @noRd
initialise_value <- function(session, inputId, n) {
  session$sendInputMessage(
    inputId = inputId,
    message = list(
      type = "initiate",
      value = n
    )
  )
}
