% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shinyRatings.R
\name{shinyRatings}
\alias{shinyRatings}
\title{Include ratings in shiny UI}
\usage{
shinyRatings(inputId)
}
\arguments{
\item{inputId}{The input slot that will be used to access the value of number of stars.}
}
\value{
Ratings to be added to UI definition
}
\description{
Include ratings in shiny UI
}
\examples{
if(interactive()){
 library(shiny)
 library(shinyRatings)

ui <- fluidPage(
  shinyRatings('star'), 
  textOutput('text')
)

server <- function(input, output, session) {
   output$text <- renderText({paste("No. of stars : ", input$star)})
}

shinyApp(ui, server)
}

}
