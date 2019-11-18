weather_df <-
  read.csv("/Users/jayrg007/Desktop/INFO201/data-science-project-info-201/data/weather.csv",
           stringsAsFactors = FALSE)

show_by_given_temp <- function(temperature) {
  a <- weather_df %>%
    select(temp == temperature)
}


