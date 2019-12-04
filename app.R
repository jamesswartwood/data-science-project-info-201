#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(DT, warn.conflicts = FALSE)
library(leaflet, warn.conflicts = FALSE)
library(shiny, warn.conflicts = FALSE)
library(shinythemes, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)


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
               requires our immeditate attention because there are several
               things being affected because of it. Such as the greenhouse
               effect, causing ice caps to melt, and thus, rainsing
               sea levels."),
    p(h5("Our questions for this project are:")),
    tags$li("Has global warming become more apparent in
                    recent years?"),
    tags$li("Is global Warming a natural phenomenon or due to
                    human advancement?")
  )
)



page_four <- tabPanel(
  "Conclusion",
  titlePanel("Conclusion"),
  mainPanel(
    p("Global warming is a serious issue that has been a topic of
            interest for quite some time now. There is much data out there
            pointing towards conditions that may require our immediate
            attention to save our planet and the lives of many of
            its inhabitants.
            One generally known cause of increased average global temperatures
            every year is the rise of CO2 levels in the atmosphere. While many
            people have heard of this as a direct corrilation, few know the
            extent to which this paradigm exists.
            At the beginning of this project, it was determined that we would
            collect data that would allow us to show the correlation visually
            and in a context that the average person would be able to easily
            understand in a short amount of time. This required us to search
            for detailed and accurate data from multiple sources, sort through
            the information, organize it into a summary, and then convert the
            data into visualizations that are readily available on our
            Shiny application.
              This project hopefully serves to remind people about the reality
              of climate change and how it is not something that we can put off
              dealing with forever. It might also inspire people to further
              research the issue and come to conclusions on how they might
              take part in the preservation and recovery of our planet
              and peoples.")
  )
)

page_five <- tabPanel(
  "About the tech",
  titlePanel("About the tech"),
  mainPanel(
    p("For this project, we used R to wrangle all of our data, and
          Shiny to create this app and all the vizualisations."),
    tags$a(
      href = "https://github.com/jamesswartwood/
            data-science-project-info-201/wiki",
      "Technical Report"
    )
  )
)

page_six <- tabPanel(
  "About us",
  titlePanel("About us"),
  mainPanel(
    tags$li("Jeffrey Luu: Freshman from Renton, WA. Undeclared Major."),
    tags$li("James Swartwood: Freshman from Seattle, WA. Computer Science
            Major in the Paul G. Allen School of Computer Science and
            Engineering. Software Engineering Intern at Fresh Consulting."),
    tags$li("Donald Lee: Freshman from Hong Kong. Undeclared Major."),
    tags$li("Jayr Gudino: Freshman from Quincy, WA. Undeclared Major.")
  )
)
Viz1 <- tabPanel(
  "Data Table 1",
  titlePanel(
    "Data Table 1"
  ),
  sidebarLayout(
    sidebarPanel(
      textInput(
        "year_input",
        label = h3("Type a year from 1970-2013"),
        value = "1970"
      )
    ),
    mainPanel(
      DT::dataTableOutput("table")
    )
  )
)

Viz2 <- tabPanel(
  "Data Table 2",
  titlePanel(
    "Data Table 2"
  ),
  sidebarLayout(
    sidebarPanel(
      textInput(
        "year_input_viz2",
        label = h3("Type a year from 1970-2013"),
        value = "1970"
      ),
      textInput(
        "country",
        label = h3("Type a country"),
        value = "United States"
      )
    ),
    mainPanel(
      DT::dataTableOutput("country_table")
    )
  )
)

Viz3 <- tabPanel(
  "Plot",
  titlePanel(
    "Plot"
  ),
  sidebarLayout(
    sidebarPanel(
      textInput(
        "country_viz3",
        label = h3("Type a country"),
        value = "India"
      )
    ),
    mainPanel(
      plotOutput("temperature_plot"),
      p("This plot is showing us how the average temperatures are
      increasing as the years go by for a specific country.")
    )
  )
)
ui <- navbarPage(
  "Global Warming",
  theme = shinytheme("cerulean"),
  page_one,
  page_two,
  navbarMenu(
    "Vizualisations",
    Viz1,
    Viz2,
    Viz3
  ),
  page_four,
  page_five,
  page_six
)
server <- function(input, output) {
  weather_table_output <- reactive({
    weather_table <- final_weather_df %>%
      filter(Year == input$year_input)
    weather_table
  })

  country_table_output <- reactive({
    output_table <- final_weather_df %>%
      filter(Country == input$country) %>%
      filter(Year == input$year_input_viz2)
    output_table
  })

  weather_plot <- reactive({
    temp_table <- final_weather_df %>%
      filter(Country == input$country_viz3)
    temp_plot <- ggplot(
      temp_table,
      aes(x = as.numeric(Year), y = AverageTemp)
    ) +
      geom_col(aes(fill = CO2), width = 2.0) +
      xlab("Year") +
      ggtitle(paste0("Temperature vs. Years for ", input$country_viz3)) +
      coord_flip()

    temp_plot
  })
  output$table <- DT::renderDataTable({
    weather_table_output()
  })
  output$country_table <- DT::renderDataTable({
    country_table_output()
  })

  output$temperature_plot <- renderPlot({
    weather_plot()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
