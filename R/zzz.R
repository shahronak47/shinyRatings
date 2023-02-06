.onLoad <- function(...) {
  shiny::addResourcePath(
    prefix = "files", 
    directoryPath = system.file("exdata", package = "shinyRatings") # path to resource in your package
  )
}