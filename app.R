#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
page_one <- tabPanel(
    "Intro",
    titlePanel("Intro"),
    
        mainPanel(
            p("Intro paragraph here")
        )
)

page_two <- tabPanel(
    "Background and Research Quesstions",
    titlePanel("Background and Research Questions"),
    
        mainPanel(
            p("Information here")
        )
)

page_three <- tabPanel(
    "Vizualisations",
    titlePanel("Vizualisations"),
    
    sidebarLayout(
        sidebarPanel(
            p("Controls for the viz will go here")
        ),
        mainPanel(
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
        p("Info about the tech will go here")
    )
)

page_six <- tabPanel(
    "About us",
    titlePanel("About us"),
    
    mainPanel(
        p("Info about us will go here")
    )
)

ui  <- navbarPage(
    "Global Warming",
            page_one,
            page_two,
            page_three,
            page_four,
            page_five,
            page_six
        
    
)

server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
