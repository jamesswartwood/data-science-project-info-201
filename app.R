#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(leaflet)
library(shiny)
library(shinythemes)

source("weather_analysis.R")

page_one <- tabPanel(
    "Intro",
    titlePanel("Introduction"),
        mainPanel(
            h4("The University of Washington"),
            h4("The Information School"),
            h4("INFO 201"),
            tags$li("Jeffrey Luu"),
            tags$li("James Swartwood"),
            tags$li("Donald Lee"),
            tags$li("Jayr Gudino"),
            h4("This project will give us insights on which countries
            are producing the most CO2 and will show how this affects
            the temperatures in
            the given contries.")
        )
)

page_two <- tabPanel(
    "Background and Research Questions",
    titlePanel("Background and Research Questions"),
        mainPanel(
            h5("Some background: Global Warming is a serious issue and it
               requires our immeditate attention because there are several things
               being affected because of it. Such as the greenhouse effect,
               causing ice caps to melt, and thus, rainsing sea levels."),
            p(h5("Our questions for this project are:")),
            tags$li("Has global warming become more apparent in recent years?"),
            tags$li("Is global Warming a natural phenomenon or due to
                    human advancement?")
        )
)

page_three <- tabPanel(
    "Vizualisations",
    titlePanel("Vizualisations"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(
                "temp",
                label = h3("Select Temperature Range"),
                min = -25,
                max = 35,
                value = c(-25, 35))
        ),
        mainPanel(
            textOutput("table"),
            p("Vizualisations will go here")
        )
    )
)

page_four <- tabPanel(
    "Conclusion",
    titlePanel("Conclusion"),
    
        mainPanel(
            p("Our conclusion will go here")
        )
)

page_five <- tabPanel(
    "About the tech",
    titlePanel("About the tech"),
    
    mainPanel(
        p("For this project, we used R to wrangle all of our data, and
          Shiny to create this app and all the vizualisations."),
        tags$a(
            href="https://github.com/jamesswartwood/
                  data-science-project-info-201/wiki"
                , "Technical Report")
    )
)

page_six <- tabPanel(
    "About us",
    titlePanel("About us"),
    mainPanel(
        tags$li("Jeffrey Luu:"),
        tags$li("James Swartwood:"),
        tags$li("Donald Lee"),
        tags$li("Jayr Gudino:")
    )
)

ui  <- navbarPage(
    "Global Warming",
    theme = shinytheme("superhero"),
            page_one,
            page_two,
            page_three,
            page_four,
            page_five,
            page_six
        
    )
server <- function(input, output) {
    table_output <- reactive({
        table <- df %>%
            filter(AverageTemp >= temp$min) %>%
            filter(AverageTemp <= temp$max) %>%
            kable()
    })
    
    output$table <- renderText({
        table_output()
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
