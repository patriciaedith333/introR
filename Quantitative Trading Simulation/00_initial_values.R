#' --------------------------------------------------------------------- '#
#'         Variables required for the initial UI pages to load 
#' --------------------------------------------------------------------- '#
#' 

possible_selection <- c("MSFT", "GOOG", "AAPL", "META",
                        "CSCO", "INTC", "GS", "BAC",  
                        "V", "AXP", "BLK", "C", "TSLA", 
                        "DPZ", "AMZN", "PCAR", "NKE", 
                        "MCD", "CVS", "JNJ", "UNH",
                        "CI", "PFE", "BMY")
initial_selection <- c("MSFT", "GOOG", "GS", "AAPL", "TSLA", "META", "UNH", "BMY")
initial_value_one_stock <- "MSFT"
initial_value_start_date <- "2023-01-01"

#' --------------------------------------------------------------------- '#
# Portfolio Variables ----
#' --------------------------------------------------------------------- '#
#'        Variables required for the portfolio management 
#' --------------------------------------------------------------------- '#
available_investment <- 100000 # $100K - This is the balance available for investment 
portfolio_tech <- 30 # No more than 30% of technology stocks
available_tech_investment <- portfolio_tech/100*available_investment
portfolio_fin <- 30 # No more than 30% of financial stocks
available_fin_investment <- portfolio_fin/100*available_investment
portfolio_health <- 20 # No more than 20% of healthcare stocks
available_health_investment <- portfolio_health/100*available_investment
portfolio_cons <- 20 # No more than 20% of consumer discretionary stocks
available_cons_investment <- portfolio_cons/100*available_investment

stock_category <- c(MSFT = "Tech", GOOG = "Tech", AAPL = "Tech", META = "Tech",
                    CSCO = "Tech", INTC = "Tech", GS = "Fin", BAC = "Fin",  
                    V = "Fin", AXP = "Fin", BLK = "Fin", C = "Fin", TSLA = "Cons", 
                    DPZ = "Cons", AMZN = "Cons", PCAR = "Cons", NKE = "Cons", 
                    MCD = "Cons", CVS = "Health", JNJ = "Health", UNH = "Health",
                    CI = "Health", PFE = "Health", BMY = "Health"
)
