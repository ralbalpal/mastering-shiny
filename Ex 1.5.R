library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  plotOutput("plot") #1 tableOutput to plotOutput
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  output$summmary <- renderPrint({ #2 correct spelling
    summary(dataset())
  })
  output$plot <- renderPlot({
    plot(dataset()) #3 dataset to dataset()
  }, res = 96)
}

shinyApp(ui, server)