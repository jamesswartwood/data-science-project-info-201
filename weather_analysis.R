weather_df <-
  read.csv("./data/weather.csv", stringsAsFactors = FALSE)

co2_df <-
  read.csv("./data/CO2_data.csv")

View(co2_df)

show_by_given_temp <- function(temperature) {
  a <- weather_df %>%
    select(temp == temperature)
}


