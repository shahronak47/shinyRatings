#' Include ratings in shiny UI
#'
#' @param inputId The input slot that will be used to access the value of number of stars.
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
shinyRatings <- function(inputId) {
  htmltools::tags$html(
    htmltools::tags$head(
      htmltools::tags$link(type = "text/css", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css", rel = "stylesheet"),
      htmltools::tags$link(type = "text/css", href = "files/style.css", rel = "stylesheet"), 
      htmltools::tags$script(src="files/shinyRatingsBinding.js"),
    ),
    htmltools::tags$body(
      shiny::div(id = inputId, class = "shinyRatings", 
                 htmltools::HTML(ratings_html())
                )
    )
  )
}

#' @noRd
ratings_html <- function() {
  gen_seq <- seq(0.5, 5, 0.5)
  seq_chr <- sub('.', '', fixed = TRUE, formatC(gen_seq, digits = 1, format = "f"))
  dynamic_html <- paste0(sprintf('<label aria-label="%s stars" class="rating__label rating__label--half" for="rating2-%s"><i class="rating__icon rating__icon--star fa fa-star-half"></i></label><input class="rating__input" name="rating2" id="rating2-%s" value="%s" type="radio">', gen_seq, seq_chr, seq_chr, gen_seq), collapse = "")
  sprintf('<div class="rating-group">%s</div>', dynamic_html)
}
