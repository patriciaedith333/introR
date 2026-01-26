# -----------------------------------------------------------------------------  
# Function: macd_portfolio  
# -----------------------------------------------------------------------------  

# Purpose: Backtest a sector-constrained portfolio strategy using MACD entry/exit signals.  
# Input: overallStockData (dataframe with "TakePositionMACD" and "exitPositionMACD" columns).  
# Output: Updated dataframe with "entry_stock_value" and "exit_amount_value" columns.  

# -----------------------------------------------------------------------------  
# Step-by-Step Instructions  
# -----------------------------------------------------------------------------  
#'  
#' 1. **Initialize Columns**:  
#'    - Create `entry_stock_value` and `exit_amount_value` columns in `overallStockData`, initializing both to `0`.  
#'  
#' 2. **Sector Investment Allocation**:  
#'    - Define `sector_wise_investment` as a list with sector allocations (e.g., Tech, Fin) using the global variables:  
#'      - `portfolio_tech`, `portfolio_fin`, etc. (from `00_initial_values.R`).  
#'      - `available_investment` (total funds allocated to the strategy).  
#'  
#' 3. **Sort Data**:  
#'    - Arrange `overallStockData` by `date` to ensure chronological order.  
#'  
#' 4. **Loop Through Each Row**:  
#'    - For each row in `overallStockData`:  
#'      - Extract the stock `Symbol` and determine its sector using the predefined `stock_category` list.  
#'      - Check if `TakePositionMACD > 0` (entry signal) **AND** the sector’s allocated investment is > 0.  
#'        - If true:  
#'          - Calculate `entry_stock_value` as `available_sector_investment / Open` price.  
#'          - Record the entry in `entry_stocks` and `entry_value` lists.  
#'          - Set the sector’s remaining allocation to `0` (funds committed).  
#'      - Check if `exitPositionMACD > 0` (exit signal) **AND** the stock has an active position.  
#'        - If true:  
#'          - Calculate `exit_v` (exit value) as `entry_stocks * Open` price.  
#'          - If `exit_v > entry_v`, record `exit_amount_value` and reallocate funds to the sector.  
#'          - Remove the stock from `entry_stocks` and `entry_value`.  
#'  
#' 5. **Return Data**:  
#'    - Return the modified `overallStockData` with entry/exit values.  
#'  
#' ------------------------------------------------  
#' **Note**: `portfolio_tech`, `portfolio_fin`, `available_investment`, and `stock_category` are predefined in  
#' `00_initial_values.R` and remain unchanged.  
# -----------------------------------------------------------------------------  

macd_portfolio <- function(overallStockData = NULL) {  
  # TODO: Implement the portfolio allocation logic below.  
  # ... (Your code here)  
  return(overallStockData)  
}  