library(shiny)
library(ggplot2)
library(shinythemes)
library(quantmod)
library(tidyverse)
library(lubridate)

# Load all the required script files with the 
source("00_initial_values.R")
#source("01_fetchStockData.R")
#source("02_computeMACD.R")
#source("03_buildPortfolio.R")
#source("04_calculateProfit.R")
#source("05_MACD_daily_portfolio.R")

ui <- fluidPage(
  tagList(
    navbarPage(
      theme = shinytheme("cerulean"),
      "Trading Strategy",
      tabPanel("Inputs panel", sidebarPanel(
        checkboxGroupInput("list_of_stocks","Select Stocks",
                           choices = possible_selection,
                           selected = initial_selection),
        textInput("singleStock", "Enter Symbol: ", 
                  value = initial_value_one_stock, 
                  placeholder = initial_value_one_stock),
        textInput("startDate", "Start Date: ", 
                  value = initial_value_start_date, 
                  placeholder = initial_value_start_date),
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("Plot the close price of all the stocks",
                   plotOutput("plot1")), 
          tabPanel("Plot MACD - Single Stock: Invest/Sell Points", 
                   plotOutput("plot2")),
          tabPanel("Plots",
                   fluidRow(
                     column(8, plotOutput("plot3")),
                     column(4, tableOutput("profitDataPortfolio"))
                   ),
                   fluidRow(
                     column(10, plotOutput("plot4"))
                   )
          )
        )
      ))
    )
  )
)

server = function(input, output) {
  
  output$plot1 <- renderPlot(
    {
      overallStockData <- readRDS("01_dontuse_overallStockData2024.rds")
      plot_title <- paste("Average Closing Price for", paste(list_of_stocks, collapse = ", "))
      overallStockData %>%
        group_by(date) %>% 
        summarise(mean_close = mean(Close)) %>%
        ungroup() %>%
        ggplot() +
        geom_area(aes(x = date, y = mean_close), fill = "#1E1656", alpha = 0.2) + 
        geom_line(aes(x = date, y = mean_close), color = "#1E1656", linewidth = 1) +  # Thinner line
        # Final value annotation (no start point to reduce clutter)
        geom_point(aes(x = max(date), y = mean_close[which.max(date)]), color = "#1E1656", size = 3) +
        geom_text(
          aes(x = max(date), y = mean_close[which.max(date)], 
              label = paste0("$", round(mean_close[which.max(date)], 2))),
          hjust = 0.5, vjust = 2, color = "#1E1656", fontface = "bold", size = 3.5
        ) +
        theme_minimal() +
        theme(
          plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
          axis.text.x = element_text(angle = 45, hjust = 1, size = 9),  # Rotated labels
          axis.title = element_text(size = 11),
          panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
          plot.margin = margin(1, 1.5, 1, 1, "cm")  # Add margin for rotated labels
        ) +
        labs(
          title = plot_title,
          x = NULL,  # Removed "Date" label (implied by axis)
          y = "Average Closing Price ($)"
        ) +
        scale_x_date(
          date_breaks = "2 months",  # Fewer breaks - Increase if selecting larger timeframe 
          #date_labels = "%b '%y",
          #expand = expansion(add = c(5, 15))
        ) #+
      #scale_y_continuous(labels = scales::dollar_format(accuracy = 1))
    }
  )
  
  output$plot2 <- renderPlot(
    {
      stockData <- readRDS("02_dontuse_MSFT_MACD2024.rds") # Should be created from 02_computeMACD.R function.
      ggplot(stockData, aes(x = date)) +
        # Main MACD and signal lines with better colors and sizes
        geom_line(aes(y = macd), color = "purple", linewidth = 1, show.legend = T) +
        geom_line(aes(y = signal), color = "brown", linewidth = 0.8, show.legend = T) +
        
        # Add buy signals with styling (fill and line colors)
        geom_point(
          data = stockData[stockData$takePositionMACD > 0, ],
          aes(y = signal), 
          color = "#27AE60", 
          size = 3,
          shape = 24,
          fill = "#105c2d"
        ) +
        
        # Add buy price labels with positioning vjust 
        geom_text(
          data = stockData[stockData$takePositionMACD > 0, ],
          aes(y = signal, label = paste0("$", round(as.numeric(takePositionMACD), 0))),
          color = "#27AE60",
          size = 4,
          vjust = 2.5,
          fontface = "bold"
        ) +
        
        # Add sell signals with styling (fill colors and line colors)
        geom_point(
          data = stockData[stockData$exitPositionMACD > 0, ],
          aes(y = signal), 
          color = "red", 
          size = 3,
          shape = 25,
          fill = "#fca903"
        ) +
        
        # Add sell price labels with positioning vjust 
        geom_text(
          data = stockData[stockData$exitPositionMACD > 0, ],
          aes(y = signal, label = paste0("$", round(as.numeric(exitPositionMACD), 2))),
          color = "#E74C3C",
          size = 3.5,
          vjust = -2.5,
          fontface = "bold"
        ) +
        
        # Add a horizontal line at zero for reference
        geom_hline(yintercept = 0, linetype = "dashed", color = "darkgray", alpha = 0.7) +
        
        # labels and title
        labs(
          title = "MACD Trading Signals",
          subtitle = "Buy (▲) and Sell (▼) points based on MACD/Signal crossovers",
          x = "",
          y = "Value"
        ) +
        
        # Some theme formatting (Still not great)
        theme_minimal() +
        theme(
          plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
          plot.subtitle = element_text(size = 10, hjust = 0.5, color = "blue"),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(color = "gray90"),
          axis.title.y = element_text(face = "bold", margin = margin(r = 10)),
          legend.position = "topright"
        ) +
        
        # Add a legend for clearer interpretation
        annotate("text", x = min(stockData$date), y = max(c(stockData$macd,stockData$signal), na.rm = TRUE), 
                 label = "— MACD Line (purple color)     — Signal Line (brown color)", hjust = 0, 
                 color = "black", size = 3.5)
    }
  )
  
  output$plot3 <- renderPlot({
    overallMACDEntryExit <- data.frame()
    list_of_stocks <-  input$list_of_stocks
    #for (stock in list_of_stocks){
    #  stockData <- overallStockData %>% 
    #    filter(Symbol == stock)
    #  stockData <- macd_strategy_portfolio (stockData)
    #  overallMACDEntryExit <- rbind(overallMACDEntryExit, stockData)
    #}
    overallMACDEntryExit <- readRDS("03_dontuse_overallMACDEntryExit.rds")
    #overallMACDPortfolio <- macd_portfolio(overallStockData = overallMACDEntryExit)
    overallMACDPortfolio <- readRDS("04_dontuse_overallMACDPortfolio.rds")
    #dailyPortfolio <- daily_portfolio(overallMACDPortfolio) 
    dailyPortfolio <- readRDS("05_dontuse_dailyPortfolio.rds")
    
    # Plot title 
    plot_title <- paste("MACD Trading Signals for", input$singleStock)
    
    # line plots with two different lines 
    dailyPortfolio %>%
      pivot_longer(cols = c(current_investment, portfolio_value),
                   names_to = "investment_type",
                   values_to = "value") %>%
      ggplot() +
      geom_line(aes(x = Date, y = value, color=investment_type),
                linewidth=1.25) +
      scale_color_manual(values = c("#672146", "#00FF00")) +
      geom_label(aes(x = dailyPortfolio[nrow(dailyPortfolio), "Date"], 
                     y = dailyPortfolio[nrow(dailyPortfolio), "portfolio_value"], 
                     label = paste("Current Value:", round(dailyPortfolio[nrow(dailyPortfolio), "portfolio_value"], 2))), 
                 color = "#672146", hjust = 1)
  })
  
  output$profitDataPortfolio <- renderTable({
    overallProfitDF <- data.frame()
    #overallMACDPortfolio <- macd_portfolio(overallStockData)
    overallMACDPortfolio <- readRDS("04_dontuse_overallMACDPortfolio.rds")
    #for (s in list_of_stocks) {
    #  df <- overall_profit_portfolio(overallMACDPortfolio %>% filter(Symbol == s), s)
    #  overallProfitDF <- rbind(overallProfitDF, df)
    #}
    overallProfitDF <- readRDS("06_dontuse_overallProfitDF.rds")
    overallProfitDF %>%
      arrange(desc(profit))
  })
  
  output$plot4 <- renderPlot({
    
    overallProfitDF <- data.frame()
    #overallMACDPortfolio <- macd_portfolio(overallStockData)
    overallMACDPortfolio <- readRDS("04_dontuse_overallMACDPortfolio.rds")
    #for (s in list_of_stocks) {
    #  df <- overall_profit_portfolio(overallMACDPortfolio %>% filter(Symbol == s), s)
    #  overallProfitDF <- rbind(overallProfitDF, df)
    #}
    overallProfitDF <- readRDS("06_dontuse_overallProfitDF.rds")
    overallProfitDF %>%
      arrange(desc(profit))
    
    #bar chart
    ggplot(overallProfitDF, aes(x = reorder(symbol, -profit), y = profit, fill = profit)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = round(profit, 2)), vjust = -0.5, size = 5) + 
      scale_fill_gradient(low = "red", high = "green") +
      labs(title = "Profit per stock in descending order", x = "Stock Symbol", y = "Profit") +
      theme(plot.title = element_text(hjust = 0.5, size = 12))
  })
}

shinyApp(ui = ui, server = server)