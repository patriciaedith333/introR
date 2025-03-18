#Patricia Condori

library(shiny)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(TTR)
library(quantmod)

getSymbols("AAPL", src = "yahoo", from = "2021-01-01", to = "2025-12-31", auto.assign = TRUE)
stock_data <- data.frame(Date = index(AAPL), coredata(AAPL)[, c("AAPL.Close")])
colnames(stock_data) <- c("Date", "Close")

stock_data$SMA50 <- SMA(stock_data$Close, n = 50)
stock_data$SMA200 <- SMA(stock_data$Close, n = 200)

crossovers <- stock_data %>%
  mutate(
    Signal = case_when(
      lag(SMA50) < lag(SMA200) & SMA50 > SMA200 ~ "Golden Cross",
      lag(SMA50) > lag(SMA200) & SMA50 < SMA200 ~ "Death Cross",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(Signal))

ui <- fluidPage(
  titlePanel("AAPL Stock Analysis"),
  
  tabsetPanel(
    tabPanel("SMA Analysis",
             plotOutput("sma_plot")
    ),
    tabPanel("Crossover Analysis",
             plotOutput("crossover_plot")
    )
  )
)

server <- function(input, output) {
  
  # SMA Analysis Plot
  output$sma_plot <- renderPlot({
    ggplot(stock_data, aes(x = Date)) +
      geom_line(aes(y = Close, color = "Close"), size = 0.5) +
      geom_line(aes(y = SMA50, color = "SMA50"), size = 1.2) +
      geom_line(aes(y = SMA200, color = "SMA200"), size = 1.2) +
      geom_text(data = crossovers, aes(x = Date, y = Close, label = round(Close, 2)),
                color = "black", size = 4, fontface = "bold", vjust = -0.5) + 
      labs(title = "AAPL Stock Price with SMAs and Crossover Points",
           x = "Date", y = "Price") +
      scale_color_manual(values = c("Close" = "blue", "SMA50" = "red", "SMA200" = "gray")) +
      theme_minimal()
  })
  
  # Crossover Analysis Plot
  output$crossover_plot <- renderPlot({
    ggplot(stock_data, aes(x = Date)) +
      geom_line(aes(y = Close), color = "blue", size = 0.5) +
      geom_text(data = crossovers, aes(y = Close, label = round(Close, 2), color = Signal), 
                size = 5, fontface = "bold", vjust = -0.5) +  # Increased font size
      scale_color_manual(values = c("Golden Cross" = "green", "Death Cross" = "red")) +
      labs(title = "AAPL Close Price and Crossover Signals",
           x = "Date", y = "Price") +
      theme_minimal()
  })
  
}

shinyApp(ui = ui, server = server)