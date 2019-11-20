<<<<<<< HEAD
weather_df <-
  read.csv("./data/weather.csv", stringsAsFactors = FALSE)

co2_df <-
  read.csv("./data/CO2_data.csv")

View(co2_df)

show_by_given_temp <- function(temperature) {
  a <- weather_df %>%
    select(temp == temperature)
}
=======
weather_df <- read.csv("data/weather.csv", stringsAsFactors = FALSE)
CO2_df <- read.csv("data/CO2_data.csv", stringsAsFactors = FALSE)
>>>>>>> c6505f6e39651741179d721dc56a7cf19fd439f5

library(dplyr)
library(tidyr)

removeX <- function(string) {
  return(gsub("X", "", string))
}

selectYear <- function(date) {
  return(format(as.Date(date, format="%Y-%m-%d"),"%Y"))
}

selectYear2 <- function(date) {
  return(format(as.Date(date, format="%Y"),"%Y"))
}

weather_df <- read.csv("data/weather.csv", stringsAsFactors = FALSE)
weather_df <- weather_df %>%
  mutate(Year = weather_df$dt) %>%
  select(Year, Country, AverageTemperature)
weather_df$Year <- lapply(weather_df$Year, selectYear)

CO2_df <- read.csv("data/CO2_data.csv", stringsAsFactors = FALSE)
CO2_df <- CO2_df %>%
  mutate(Country = CO2_df$ï..Country.Name) %>%
  gather(key = Year, value = CO2, X1960:X) %>%
  select(Year, Country, CO2)
CO2_df$Year <- lapply(CO2_df$Year, removeX)
CO2_df$Year <- lapply(CO2_df$Year, selectYear2)

df <- weather_df %>%
  left_join(CO2_df, by = c("Country", "Year"))
