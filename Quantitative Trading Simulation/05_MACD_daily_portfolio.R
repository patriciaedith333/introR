# -----------------------------------------------------------------------------  
# Function: daily_portfolio  
# -----------------------------------------------------------------------------  

# Purpose: Track daily changes in portfolio value based on MACD-driven trades.  
# Input: overallStockData (dataframe with "entry_stock_value" and "exit_amount_value" columns).  
# Output: Daily dataframe with columns: Date, current_investment, amount_not_invested, portfolio_value.  

# -----------------------------------------------------------------------------  
# Step-by-Step Instructions  
# -----------------------------------------------------------------------------  
#'  
#' 1. **Initialize Variables**:  
#'    - Create `sector_wise_investment` using predefined sector allocations (`portfolio_tech`, `portfolio_fin`, etc.) from `00_initial_values.R`.  
#'    - Initialize `current_investment`, `amount_not_invested`, and `portfolio_value` with `available_investment` (global variable).  
#'    - Create an empty list `current_investment_list` to track active positions.  
#'  
#' 2. **Sort Data**:  
#'    - Arrange `overallStockData` by `date` to ensure chronological processing.  
#'  
#' 3. **Loop Through Each Row**:  
#'    - For each row in `overallStockData`:  
#'      - **Track Date Changes**:  
#'        - If the current row’s date differs from the previous day **OR** it’s the last row:  
#'          - Add a new row to `dailyPortfolio` with the previous day’s metrics.  
#'      - **Handle Entry Signals**:  
#'        - If `entry_stock_value > 0`:  
#'          - Deduct the invested amount from `amount_not_invested`.  
#'          - Add the investment to `current_investment` and track it in `current_investment_list`.  
#'      - **Handle Exit Signals**:  
#'        - If `exit_amount_value > 0`:  
#'          - Add the exit amount to `amount_not_invested`.  
#'          - Calculate profit/loss and update `portfolio_value`.  
#'          - Remove the exited stock from `current_investment_list`.  
#'  
#' 4. **Finalize Daily Snapshot**:  
#'    - Ensure the last day’s data is added to `dailyPortfolio`.  
#'  
#' 5. **Return Data**:  
#'    - Return the `dailyPortfolio` dataframe with columns:  
#'      - `Date`, `current_investment`, `amount_not_invested`, `portfolio_value`.  
#'  
# -----------------------------------------------------------------------------  
#' **Note**: `portfolio_tech`, `portfolio_fin`, `available_investment`, and `stock_category` are predefined in `00_initial_values.R` and remain unchanged.  
# -----------------------------------------------------------------------------  

daily_portfolio <- function(overallStockData = NULL) {  
  # TODO: Implement daily portfolio tracking logic below.  
  # ... (Your code here)  
  return(data.frame())  
}  