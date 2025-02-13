library(quantmod)
library(TTR)
        
        #SMA simple moving avg , EMA exponential moving avg

# Question 1: Write a function get_stock_data() that takes a stock symbol and a date range as input ----
# and returns a data frame containing the stock data for that period. 
# The function should handle potential errors, such as invalid stock symbols.
?getSymbols   

get_stock_data<- function(symbol = NULL, 
                          start_date = NULL, 
                          end_date = NULL) {
  df <- getSymbols(Symbols = symbol,
                   auto.assign = getOption("getsymbols.auto.assign", F),
                   from=start_date,
                   to=end_date
  )
  
  colnames(df) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
  
  return(df)
}
get_stock_data()

df<-get_stock_data("TSLA", 
                   "2024-01-01",
                   "2025-02-01")
                             
# Question 2:  Write a function plot_stock_prices() that takes a stock data object (as returned by get_stock_data()) ----
# and a price type ("Close", "Adjusted", etc.) as input and creates a base plot of the specified price over time. 
# The function should handle customization of plot appearance (color, title, labels, etc.). 
plot(df$close,
     main= "Close price", 
     col="red")
plot_stock_prices <- function(df = NULL, column_name = NULL){
  df<-as.data.frame(df)
  plot(x=as.Date(row.names(df)),
       y=df[[column_name]], type = "1",
       xlab="Date",
       ylab=column_name)
}
df<-get_stock_data("TSLA", 
                   "2024-01-01",
                   "2025-02-01")
plot_stock_prices(df)

# Question 3: Fetch daily price data for one single stock of your choice for the past year. ----
# Hint: Reuse the function previously created 
# Create a multi-panel plot showing the "Open", "High", "Low", and "Close" prices in separate panels. 
# Use different colors for each price type and add appropriate titles and labels.

my_favorite_stock <- get_stock_data("TSLA", 
"2024-01-01",
"2025-02-01")

par(mfrow=c(2,2))
plot_stock_prices(my_favorite_stock, 'Open')
plot_stock_prices(my_favorite_stock, 'High')
plot_stock_prices(my_favorite_stock, 'Close')
plot_stock_prices(my_favorite_stock, 'Adjusted')

# Question 4: Fetch weekly price data for a good stock, say Microsoft (MSFT) for the past two years. ----
# Note: By default daily data is returned. Use to.weekly()
# Create a single plot (with two panes) showing the "Adjusted" price as a line on one side, and the "Volume" on the other side. 
#1. Use to weekly  (<on daily xts data>)
#2. set mfrow to two panes and plot Adjusted and volume
my_fav_stock_weekly <- to.weekly(my_favorite_stock)
names(my_fav_stock_weekly)<-c("Open", 'High', "Low", 'Close', 'Volume', 'Adjusted')
par(mfrow=c(1,2))
plot_stock_prices(my_fav_stock_weekly, 'Adjusted')
plot_stock_prices(my_fav_stock_weekly, 'Volume')

# Question 5: Implement a Golden Cross trading strategy for a chosen stock (e.g., Apple - AAPL) over the past 5 years. ----
# Fetch the daily stock price data using quantmod.
# Calculate the 50-day and 200-day moving averages.
# Identify the Golden Cross points (where the 50-day MA crosses above the 200-day MA). 
# Plot 50-day and 200-day lines in different colors.
# Generate a plot of the stock prices along with the moving averages.

my_favorite_stock$SMA50 <- 0
#var2;'data.frame'(var1)
#names(my_favorite_stock)
#var1<-c(12, 40, 30, 60, 30)
#length(SMA(var1, 3))

my_favorite_stock$SMA50 <- SMA(my_favorite_stock$close, 50)
my_favorite_stock$SMA200 <- SMA(my_favorite_stock$close, 200)

par(mfrow=c(1,1))
plot_stock_prices(my_favorite_stock, "close")
lines(my_favorite_stock$SMA50, col="blue")
lines(my_favorite_stock$SMA200, col="red")


install.packages(c("quantmod", "TTR"))