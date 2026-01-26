# -----------------------------------------------------------------------------
# Boilerplate to complete
# Function: computeMACD
# -----------------------------------------------------------------------------

# Purpose: Compute MACD indicator values for the provided stock data.
# This function performs backtesting of a MACD (Moving Average Convergence Divergence) 
# crossover trading strategy on historical stock data.

#' Input Parameters:
#'    stockData: A data frame containing historical stock price data with at least the following columns:
#'      Close: Daily closing prices
#'      Open: Daily opening prices
#' Output:
#'  The function should return the original stockData with additional columns (takePositionMACD & 
#'  exitPositionMACD) that track the MACD strategy signals.
#'  
#'  Refer to 03_MACD_Invest_Exit.R First 4 steps are same for both these functions. 

computeMACD <- function(stockData) {
  # TODO: Implement MACD calculations.
  stockData <- data.frame()
  return(stockData)
}