library(dplyr)
library(tidyr)
library(knitr)

addX <- function(string) {
  return(paste("X", string, sep = ""))
}

removeX <- function(string) {
  return(gsub("X", "", string))
}

weather_df <- read.csv("data/weather.csv", stringsAsFactors = FALSE)
weather_df <- weather_df %>%
  mutate(Year = weather_df$dt) %>%
  select(Year, Country, AverageTemperature)
weather_df$Year <- weather_df$Year %>%
  sapply(substring, 1, 4) %>%
  sapply(addX)
weather_df <- weather_df %>%
  filter(!is.na(AverageTemperature)) %>%
  group_by(Year, Country) %>%
  summarize(AverageTemp = mean(AverageTemperature))

CO2_df <- read.csv("data/CO2_data.csv", stringsAsFactors = FALSE)
CO2_df <- CO2_df %>%
  mutate(Country = CO2_df$ï..Country.Name) %>%
  gather(key = Year, value = CO2, X1960:X) %>%
  select(Year, Country, CO2) %>%
  filter(!is.na(CO2))

df <- weather_df %>%
  inner_join(CO2_df, by = c("Country", "Year"))
df$Year <- lapply(df$Year, removeX)
