# -----------------------------------------------------------------------------
# Boilerplate to complete
# Function: macdInvestExit
# -----------------------------------------------------------------------------

# Purpose: Create entry and exit indicators. 
# This function processes historical stock data to flag potential buy (entry) and 
# sell (exit) signals using the MACD indicator for use in a portfolio strategy.

# Detailed steps:
#' Function Definition: 
#'  Create a function called macdInvestExit that accepts one parameter (e.g., stockData) 
#'  which is a data frame containing stock data for a single stock only.
#'  (including columns like Open, Close, etc.).
#'  
#'  1.  Convert Data Type: Inside the function, convert the "Close" column of stockData to numeric. 
#'      This ensures the MACD calculation will work correctly.
#'  2. Compute MACD Values: Use the MACD() function (from the quantmod package) on the "Close" 
#'      column to calculate the MACD values. Save these results in a variable (for example, macd) 
#'      and then combine these new columns with the original stockData using cbind().
#'      
#'  3. Create Lagged Columns: Create two new columns in stockData called prevDayMacd and prevDaySignal. 
#'      These should hold the previous day's values for the MACD and signal columns, respectively 
#'      (Hint: use dplyr::lag() for this. lag() function is also available in stats which might not work 
#'      for dataframe column).
#'      
#'  4. Determine Entry Signal: Create a new column named TakePositionMACD that will be used as an entry signal. 
#'      Set this column to 1 if the current MACD is greater than the signal AND the previous day's MACD is less 
#'      than the previous day's signal. Otherwise, set it to 0. (Hint: Use the ifelse() function.)
#'      This step is similar to the computeMACD function except, instead of 1, Open price is used in computeMACD.
#'      
#'  5. Filter Out Incomplete Data: Remove any rows from stockData where TakePositionMACD is NA. 
#'     This is often necessary because the lagged values will be NA for the first few observations. 
#'     
#'  6. For the exit strategy calculation, looping through the stockData is required. Strategy - 
#'      a)  Initialize Trading Status: Initialize a variable (for example, previousEntry) to "N". 
#'          This variable will help track whether you have an open position (i.e., an active trade).
#'      b) Start a loop that iterates through each row of stockData. In the loop:
#'          If takePositionMACD is greater than 0 for a row, set previousEntry to "Y" (indicating an entry has been made).
#'          For rows (other than the first) where previousEntry is "Y", check if the current MACD is less than the signal 
#'          AND the previous day's MACD is greater than the previous day's signal. If both conditions are met, assign 1 to 
#'          a new column called exitPositionMACD (indicating an exit signal) and set previousEntry back to "N".
#'          Otherwise, set exitPositionMACD to 0
#'      
#'  7. Convert entry & exit indicators to Numeric:
#'      After the loop, convert both TakePositionMACD and exitPositionMACD columns to numeric type, ensuring consistency in the data.
#'      (Remember, this time the TakePositionMACD and exitPositionMACD columns hold either a 0 or 1, not Open or Close prices)
#'  
#'  8. Return the Modified Data:
#'      Finally, have the function return the updated stockData data frame that now includes the original columns, 
#'      the MACD calculations, and the entry/exit signal columns.

macdInvestExit <- function(stockData) {
  # TODO: Implement portfolio investment logic.
  stockData <- data.frame()
  return(stockData)
}