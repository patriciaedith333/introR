# -----------------------------------------------------------------------------  
# Function: overall_profit_portfolio  
# -----------------------------------------------------------------------------  

# Purpose: Compute net profit for a stock using entry/exit trade data.  
# Inputs:  
#   - stockData: Dataframe with "entry_stock_value" and "exit_amount_value" columns.  
#   - sym: Stock symbol (e.g., "AAPL").  
# Output: Dataframe with columns "symbol" and "profit".  

# -----------------------------------------------------------------------------  
# Step-by-Step Instructions  
# -----------------------------------------------------------------------------  
#'  
#' 1. **Filter Relevant Trades**:  
#'    - Subset `stockData` to include only rows where `entry_stock_value > 0` **OR** `exit_amount_value > 0`.  
#'  
#' 2. **Calculate Entry Costs**:  
#'    - Add a new column `entry_amount_value` to `stockData` as `entry_stock_value * Open` price.  
#'  
#' 3. **Check for Unclosed Positions**:  
#'    - Identify the last row in `stockData`. If it has `entry_stock_value > 0` (open position), exclude it from profit calculation.  
#'  
#' 4. **Compute Net Profit**:  
#'    - Calculate `profit` as the difference between the sum of `exit_amount_value` and the sum of `entry_amount_value`.  
#'  
#' 5. **Return Results**:  
#'    - Return a dataframe with columns `symbol` (from parameter `sym`) and `profit`.  
#'  
#' ------------------------------------------------  
#' **Note**:  
#' - If `stockData` has no valid trades (`nrow(stockData) == 0`), return an empty dataframe.  
#' - Use `dplyr::last()` to check the last row and `head()` to exclude it if needed.  
# -----------------------------------------------------------------------------  

overall_profit_portfolio <- function(stockData = NULL, sym = NULL) {  
  # TODO: Implement profit calculation logic below.  
  # ... (Your code here)  
  return(data.frame())  
}   

