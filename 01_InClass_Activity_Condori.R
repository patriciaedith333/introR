---
title: "introR"
author: "Patricia Condori"
date: "2025-01-23"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.


#' Author: Patricia Condori  
#' Date Created: 01/16/2025
#' This R script demonstrates handling data in R, various data structures  
#' available, and demonstrate vector operations    

# Creating vectors ----
# Q1. Create a vector named numbers containing the integers from 1 to 20.
numbers <- seq(1, 20)

# Q2. Create a vector named names containing the following names: "Alice", "Bob", "Charlie", "David", "Emily".
names <- c("Alice", "Bob", "Charlie", "David", "Emily")

# Q3. Create a vector named mixed_data containing the following values: 10, "hello", TRUE, 3.14, 5i.
mixed_data <- c(10, "hello", TRUE, 3.14, 5i)

# Q4. Access the fourth element of the names vector created in Q2. 
print(names[4])
names[4]

# Q5. Change the third element of the numbers vector created in Q1 to 30.
numbers[3] <- 30

# Creating Lists (Uses the objects created from questions Q1 to Q5) ----  
# Q6. Create a list named my_list containing the following elements:  
#         the vector numbers, the number 100, and the logical value TRUE.
my_list <- list(numbers, 100, TRUE)


# Q7. Access the first element of the my_list list.
my_list[[1]]
#create a named list 

# Q8. Add a new element to the my_list list: the vector mixed_data from Q3.

my_list[[4]] <- mixed_data

# Creating Matrices ----  
# Q9. Create a 4x3 matrix named my_matrix with values ranging from 1 to 12, filled by column.

my_matrix<-matrix(c(,1 2, 3, 4, 5), nrow=4, ncol=3, byrow= FALSE)

# Q10. Create a 3x3 matrix named identity_matrix with 1s on the diagonal and 0s elsewhere.
matrix(c(1, 0, 0, 0, 1, 0, 0, 0, 1), byrow= TRUE, nrow= 3, ncol= 3)
matrix(c(1, 0, 0, 0, 1, 0, 0, 0, 1), 3, 3, byrow= TRUE)
diag(1, 3, 3)

identity_matrix <- diag(1, 3, 3)

# Q11. Extract the second column of the my_matrix matrix.
#[] for list, arrays, matrix and data.frame 
my_matrix <- diag(1, 3, 3) 
my_matrix[, 2]

#only one element
my_matrix[3, 3]
my_matrix[1:3, 3]
my_matrix[c(TRUE, TRUE, TRUE), 2] #well use this one with data.frames

#return all the elements from my matrix
my_list=[[1]][2]

# Q12. Calculate the determinant of the identity_matrix.

det(matrix(c(2, 4, 6, 8), 2, 2))
det(diag(1, 2, 2))

det(identity_matrix)     #alternative
# Creating Arrays ---- 

# Q13. Create a 2x3x4 array named my_array with random values between 0 and 50.  
array()

#sample function 
sample(c("A", "B", "C"), 2)
#RANDOM 24 NUMBERS 

my_array <- array(sample(c(1:50, 24), dim=c(2, 3, 4)))


# Q14. Access the element in the first row, second column, and third level of the my_array array.
my_array[1, 2, 3]

# Working with Factors ---- 
# Q15. Create a factor named education_level with levels "High School", "Bachelor's", "Master's",  
#       and values c("Bachelor's", "Master's", "High School", "Bachelor's").

x <- c("Man", "Male", "Man", "Lady", "Female")
factor(x, levels = c("Male", "Man" , "Lady",   "Female"),
       labels = c("Male", "Male", "Female", "Female"))


education_level <- factor(c("Bachelors", "Masters", "High school", "Bachelors"))
factor(c("Bachelors", "Masters", "High school", "Bachelors"), levels = c("High school", "Bachelors", "Masters"))

# Q16. Convert the character vector weekdays <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Mon", "Wed") into a factor.
weekdays <- factor(c("Mon", "Tue", "Wed", "Thu", "Fri", "Mon", "Wed"), levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))


# Q17. Print the levels of the education_level factor.
education_level
levels(education_level)
class(education_level)

# Creating Data frames. ---- 
# Q18. Create a data frame named employees with columns "name", "salary", and "department", 
#       containing the following data:
#         name: c("Alice", "Bob", "Charlie", "David")
#         salary: c(60000, 75000, 80000, 65000)
#         department: c("HR", "Finance", "Marketing", "IT")
employees <- data.frame(
  name = c("Alice", "Bob", "Charlie", "David"), 
  salary = c(60000, 75000, 80000, 65000), 
  department = c("HR", "Finance", "Marketing", "IT")
)

# Q19. Access the "salary" column of the employees data frame.

#view(employees)
employees$salary
employees[["salary"]]

column_to_pull <- "salary"
employees[[column_to_pull]]


# Q20. Add a new column named "start_date" to the employees data frame, 
#      with values c("2022-01-15", "2021-05-10", "2023-03-20", "2022-08-01").
employees$start_date <- c("2022-01-15", "2021-05-10", "2023-03-20", "2022-08-01")


# Q21. Select rows where the "salary" is greater than 70000 in the employees data frame.
employees[c(T, T, F, F),]

var1 <- c(60, 70, 80, 90) 
var2 <- var1 > 70
employees[var2, ]
employees[employees$salary > 70000,]

var2 <- employees$salary > 7000
var2
employees[var2, ]
employees[1:4, 1:4]
employees[c(1, 2), ]
employees[c(T, T, F, F), ]
employees$salary > 70000
employees[employees$salary > 70000, ]

# Q22.  You have a vector of sales figures for a year. Calculate the total sales for the year.
#instead of sales figure using salary here 
sum(employees$salary)

# Q23.  Using the same sales vector, calculate the average monthly sales.
mean(employees$salary)
sd(employees$salary)

# Q24. You have a data frame with product names and prices.  
#      Create a new column that calculates a 10% discount on each price.
products <- data.frame(product = c("A", "B", "C", "D"),
                       price = c(10, 20, 30, 40))
products$newprice <-  products$price*0.9

# Q25. Create a named vector with the following fruit prices:
#        Apple = 0.75, Banana = 0.50, Orange = 0.60, Grape = 1.20
fruits <- c(Apple = 0.75, Banana = 0.50, Orange = 0.60, Grape = 1.20)
fruits[1]
fruits["Apple"]

# Q26. Extract the price of "Orange" from the fruit_prices vector.
fruits[[3]]
fruits[3]
fruits["Orange"]

# Q27. Create a list named inventory containing the following:
#       * A vector of product IDs: 101, 102, 103
#       * A vector of product names: "Shirt", "Pants", "Shoes"
#       * A vector of quantities in stock: 50, 30, 25
                                                    
inventory <- list( product_ids = c(101, 102, 103), product_names = c("Shirt", "Pants", "Shoes"), quantities_in_stock = c(50, 30, 25) )

# Q28. Access the "quantities in stock" vector from the inventory list.
inventory$quantities_in_stock

# Q29. Create a matrix named sales_data with the following data, filled by row:
#       * Week 1:  120, 150, 135
#       * Week 2:  110, 160, 140
#       * Week 3:  130, 145, 155
#       (This represents sales of 3 different products over 3 weeks)
sales_data <- matrix(c(120, 150, 135, 110, 160, 140, 130, 145, 155), nrow = 3, ncol = 3, byrow = TRUE)

# Q30. You have a data frame with customer purchase history. 
#      Find the customer who spent the most money.
customer_data <- data.frame(
  customer_id = c(1, 2, 3, 4, 5, 6, 7, 8),
  purchase_amount = c(150, 200, 120, 180, 310, 160, 280, 250)
)
#costumer_data[5, 1]
max_amomunt_spent <- max(customer_data$purchase_amount)
customer_data[customer_data$purchase_amount == max_amomunt_spent, ]
customer_data[which(customer_data$purchase_amount == max_amomunt_spent)]


# Write the algorithm first 
#first find the max amount spent 
#match it with row selection 
# Then implement step-by-step.
#hint: use one of the variation of which

