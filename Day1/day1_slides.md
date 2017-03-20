Basic statistics and data handling
========================================================
author: Hugo Tavares (hugo.tavares@slcu.cam.ac.uk)
date: 3 Apr 2017
autosize: true
width: 1500
height: 900

Day 1 - Data organization and introduction to R


Outline of Day 1
========================================================

* Session 1 - Data Organisation (in spreadsheets)

* Session 2 - Introduction to R and Rstudio

* Session 3 - Data manipulation in R

This material is adapted from the materials developed by the 
[Data Carpentry](http://www.datacarpentry.org/) community. 

This is not a full Data Carpentry course, just a shortened version of it (but we 
do run these at the University, if you're interested).


Data Organisation (in spreadsheets)
========================================================

* Recognise and apply principles and good practices for organising your data
* Recognise common pitfalls when recording data (and learn to avoid them!)
* Understanding file formats and their suitability for other programs (e.g. R)


Data Organisation - best practices
========================================================

* Never modify the raw data - always work on a copy of it.
* Keep track of any modifications you make to the raw data.
  * for example write notes on a README.txt file or on a separate worksheet of 
  the spreadsheet file.
* Columns should contain single variables (the things that were measured).
* Rows should contain the observations (the units of study).

**Exercise**: 

```
- Open the "dataset_messy.xls" spreadsheet located in the course 
  materials folder ("Desktop > course_materials > Day1 > data")
  
- Tidy this data applying the best practices above

- Open discussion: what problems did you find? And how did you solve them?
```


Data Organisation - formatting problems
========================================================

* Data should not be placed on separate tables and worksheets.
* Zeros should be recorded as zero. Missing values should be recorded as empty 
cells or as "NA".
* Comments should be avoided. Always try to assign things to individual variables.
* Avoid special characters in the column names (and avoid spaces).
* Be *very* careful with date formatting in spreasheets:
  * different spreadsheet programs (or versions) assume different things.
  * To avoid problems, store the day, month and year in separate variables. 

See more about this topic in the 
[Data Carpentry materials](http://www.datacarpentry.org/spreadsheet-ecology-lesson/).


Data Organisation - exporting data from spreadsheets
========================================================

If possible, store/distribute data in `CSV` (comma-separated-values) format:

```
species,year,month,day,weight_kg,height_cm
mouse,2014,3,21,2,10
dog,2013,7,2,20,60
cat,2016,12,7,4.2,25
```

This can be done from any spreadsheet program by choosing "`Save As`" and then 
selecting the file format to be "`CSV`".


Tea break and a stretch
========================================================


Introduction to R and Rstudio
========================================================

* Getting to know Rstudio
* Learn basic syntax of R

This session is adapted from 
[this lesson](http://www.datacarpentry.org/R-ecology-lesson/01-intro-to-R.html) 
of the Data Carpentry materials. 


Introduction to R - defining variables
========================================================

**Exercise** 

what are the variable values after each of these statements?


```r
mass <- 47.5            # mass?
age  <- 122             # age?
mass <- mass * 2.0      # mass?
age  <- age - 20        # age?
mass_index <- mass/age  # mass_index?
```



Introduction to R - data types
========================================================

**Exercise** 

What are the data types of each of these variables?


```r
num_char <- c(1, 2, 3, 'a')
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c('a', 'b', 'c', TRUE)
tricky <- c(1, 2, 3, '4')
```

Hint: use the `class()` function.


Introduction to R - subsetting vectors
========================================================

**Exercise** 

Consider the following vector:


```r
x <- c(135, 174, 122, 185, 168, 166)
```

* Extract the values above 170 and below 150.
* Extract all values, except for the last one. *Challenge*: can you do it using `length()`?
* Extract every second value. *Challenge*: can you do it using `seq()`?


Introduction to R - missing values
========================================================

**Exercise** 

Consider the following vector:


```r
x <- c(135, NA, 122, NA, 168, 166)
```

* Calculate the median of the values
* Create a new vector `y` that does not include the missing values


Introduction to R - factor variables
========================================================

So far, we've seen **numeric**, **character** and **logical** vectors. 

There is another type of vector, which is used to represent categorical data and 
is called **factor**.

We will learn later in the course how factors are important for statistical 
analysis. For now, consider these two vectors:


```r
char_vector <- c("low", "medium", "high", "high", "low", "low")
fctr_vector <- factor(char_vector)
```

* How are they different?


Introduction to R - factor variables
========================================================


```r
char_vector
```

```
[1] "low"    "medium" "high"   "high"   "low"    "low"   
```

```r
fctr_vector
```

```
[1] low    medium high   high   low    low   
Levels: high low medium
```

While both contain the same values, factors have a new attribute called **levels** - 
the unique values that occur in the vector:


```r
levels(fctr_vector) # the levels in the factor
```

```
[1] "high"   "low"    "medium"
```

```r
nlevels(fctr_vector) # the number of levels
```

```
[1] 3
```


Introduction to R - factor variables
========================================================

Many R functions treat factors differently from character vectors. For example:


```r
summary(char_vector)
```

```
   Length     Class      Mode 
        6 character character 
```

```r
summary(fctr_vector)
```

```
  high    low medium 
     2      3      1 
```


Introduction to R - factor variables
========================================================

You cannot add values that are not listed in the levels of a factor:


```r
char_vector[1] <- "very low"
char_vector
```

```
[1] "very low" "medium"   "high"     "high"     "low"      "low"     
```

```r
fctr_vector[1] <- "very low"
fctr_vector
```

```
[1] <NA>   medium high   high   low    low   
Levels: high low medium
```

And you can have levels with no observations:


```r
fctr_vector <- fctr_vector[fctr_vector != "medium"]
summary(fctr_vector)
```

```
  high    low medium   NA's 
     2      2      0      1 
```


Introduction to R - factor variables
========================================================

The order of these levels is alphabetical by default, but it can be changed:


```r
fctr_vector <- factor(char_vector, levels = c("low", "medium", "high"))
levels(fctr_vector)
```

```
[1] "low"    "medium" "high"  
```


Introduction to R - factor variables
========================================================

"Behind the scenes" R encodes each level of a factor as an integer number.


```r
char_vector
```

```
[1] "very low" "medium"   "high"     "high"     "low"      "low"     
```

```r
as.numeric(fctr_vector)
```

```
[1] NA  2  3  3  1  1
```

So be careful when converting factors that look like numbers! 


```r
x <- factor(c(2, 4, 5, 2, 2))
x
```

```
[1] 2 4 5 2 2
Levels: 2 4 5
```

```r
as.numeric(x)
```

```
[1] 1 2 3 1 1
```

One way to do this is:


```r
as.numeric(as.character(x))
```

```
[1] 2 4 5 2 2
```

See more about factors [here](http://www.datacarpentry.org/R-ecology-lesson/02-starting-with-data.html#factors).



Data manipulation in R
========================================================

* Read data from a tabular file
* Understand how to manipulate a `data.frame` object
* Filter and summarise data

This session is adapted from 
[this lesson](http://www.datacarpentry.org/R-ecology-lesson/03-dplyr.html) 
of the Data Carpentry materials. 





Data manipulation in R - reading tabular data
========================================================

To read files into R, we first need to learn how to tell the program where 
our file is (without using the file browser!).

This is done by specifying the **path** to that file. This is like an address of 
where that file is located on the computer.

File paths are built like so:

```
directory/subdirectory/another_subdirectory/some_file.txt
```

* Each directory is split by a `/` 
* The file name comes at the end (don't forget to include the file extension)
* Spaces should be avoided, but in R they are tolerated

But what is the starting point of this *path*? 

This varies between operating system, but generally a good way to start is to look 
at the **working directory** that R is using. 

This is the *path* that R is taking as a reference while you are working. Try:


```r
getwd()
```


Data manipulation in R - reading tabular data
=========================================================
Usually, it's a good idea to define a working directory that corresponds to 
your project folder. 

Let's change our working directory to the "course_materials" folder on our 
desktop:


```r
setwd("~/Desktop/course_materials/Day1")
```

* The `~` means "home directory", which is a specific directory that corresponds 
to your user account on the computer (again, this varies between operating system).


Data manipulation in R - reading tabular data
========================================================

**Exercise** 

To read a `CSV` file into R, we use the function `read.csv()`. 

Inside the parentises you need to put the path to the file you want to read within 
quotes. 

* Read the file called "surveys_data_short.csv" located in the "data" folder.
* Assign the result to an object called `surveys`. *Hint:* like we did with vectors 
using `<-`.
* What kind of object is it? *Hint:* use the function `class()`.


Data manipulation in R - reading tabular data
========================================================

Tabular objects in R are tipically stored in **data.frame** objects.

After reading data into R it's always good to check the data. Several functions 
can help with this:


```r
# Read the data
surveys <- read.csv("data/surveys_data_short.csv")

nrow(surveys)     # number of rows
ncol(surveys)     # number of columns
str(surveys)      # structure of the object
head(surveys)     # the first few rows of data
summary(surveys)  # summary statistics for every variable
```



Data manipulation in R - reading tabular data
========================================================

**Exercise**

By default, `read.csv()` converts all character variables to factors. 

By looking at the help of `read.csv` see if you can find which option to use to 
change this behaviour.





Data manipulation in R - subsetting data frames
========================================================

As with vectors, use `[]` to subset a data.frame. However, because there are 
two dimensions in this object (rows and columns) we need to specify two indexes:

```
[rows, columns]
```

For example:


```r
surveys[1, 1]  # first row, first column
surveys[, 1]   # all rows, first column
surveys[1:4, ]   # first four rows, all columns
```

**Exercise**

* Return the first six rows and all columns except the first


Data manipulation in R - subsetting data frames
========================================================

Columns from a data.frame can be retrieved by name:


```r
surveys[, "species"]
surveys$species
```

The result from these are vectors, and can be subset just like we did before:


```r
surveys$species[1:6]  # first six values in the species column
```

```
[1] "albigula" "albigula" "albigula" "albigula" "albigula" "albigula"
```


Data manipulation in R - subsetting data frames
========================================================

Like with vectors, we can use conditions to subset our data.frame.

For example, here's all the rows for one of the species:


```r
surveys[surveys$species_id == "RO", ]
```

```
      year species_id sex hindfoot_length weight           genus  species
1936  2002         RO   F              15     12 Reithrodontomys montanus
17671 2002         RO   M              15      9 Reithrodontomys montanus
23328 2002         RO   M              15     10 Reithrodontomys montanus
26392 2002         RO   M              17      8 Reithrodontomys montanus
31521 1991         RO   F              14     11 Reithrodontomys montanus
31522 2002         RO   F              16      8 Reithrodontomys montanus
32387 2002         RO   M              17     11 Reithrodontomys montanus
32388 2002         RO   F              14     13 Reithrodontomys montanus
        taxa                plot_type
1936  Rodent                  Control
17671 Rodent         Rodent Exclosure
23328 Rodent Long-term Krat Exclosure
26392 Rodent        Spectab exclosure
31521 Rodent         Rodent Exclosure
31522 Rodent         Rodent Exclosure
32387 Rodent         Rodent Exclosure
32388 Rodent         Rodent Exclosure
```


Tea break and a stretch
========================================================

Or:

* What is the mean weight across all species?
* Subset rows without missing values for weight. *Hint:* use the `is.na()` function.


Data manipulation in R - advanced manipulations with dplyr
========================================================

`dplyr` is an R package (an extension that adds new functionality to R).

It has several functions to manipulate data.frame objects, which combined can be 
very effective and powerful to summarise data.

To install a new package, you would do:


```r
install.packages("dplyr")
```

To load the package, do:


```r
library(dplyr)
```



Data manipulation in R - advanced manipulations with dplyr
========================================================
We can think of dplyr functions as verbs. We will talk about the following:

* `select` - select specific columns
* `filter` - to filter rows
* `mutate` - to modify existing columns or create new ones
* `group_by` - to partition the data.frame into groups
* `summarise` - to apply functions to groups
* `tally` - to count observations in each group

`dplyr` commands can be chained, using a special "pipe" function `%>%`

[Here is a cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) 
that can be helpful for you in the future.


Data manipulation in R - advanced manipulations with dplyr
========================================================

**Exercise**

Using pipes, subset the survey data to include individuals collected before 
1995 and retain only the columns year, sex, and weight.


Data manipulation in R - advanced manipulations with dplyr
========================================================

**Exercise**

Create a new data frame from the survey data that meets the following criteria: 

* contains only the species_id column and a new column called hindfoot_half
* hindfoot_half will contain values that are half the hindfoot_length values
* In this hindfoot_half column, there are no NAs and all values are less than 30


Data manipulation in R - advanced manipulations with dplyr
========================================================

**Exercise**

* How many individuals were caught in each plot_type surveyed?

* Use group_by() and summarize() to find the mean, min, and max hindfoot length 
for each species (using species_id).

More advanced:

* What was the heaviest animal measured in each year? Return the columns year, 
genus, species_id, and weight.

* You saw above how to count the number of individuals of each sex using a 
combination of group_by() and tally(). How could you get the same result using 
group_by() and summarize()? Hint: see ?n.


Data manipulation in R - Exporting data
========================================================

Let's say that we were to remove all the missing data from our data and then 
wanted to save this cleaned version of it into a file (to share or later read 
into R).


```r
# Remove missing values from the data
surveys_clean <- surveys %>% 
  filter(!is.na(hindfoot_length) & !is.na(weight))
```

In the same way that there is a `read.csv` function, there is also a `write.csv` 
one. This is how it works:


```r
write.csv(surveys_clean, file = "data/surveys_clean.csv",
          row.names=FALSE)
```

* Try opening this file in a spreadsheet!


Summary of basic R
========================================================

Data types:


```r
# Vectors
x <- c(135, NA, 122, NA, 168, 166)  # a numeric vector with missing values
char_vector <- c("low", "medium", "high", "high", "low", "low")  # a character vector
fctr_vecor <- factor(char_vector, levels = c("low", "medium", "high"))  # a factor

# data.frame (tables)
y <- read.csv("data/surveys_data_short.csv")  # reading data from a file
```

Subsetting:


```r
x[c(1, 3)]  # first and third elements of x
y[c(1, 3), ]  # first and third rows of y
y[, c(1, 3)]  # first and third columns of y
```

Logical operators:

* `==` is equal to
* `!=` is different from
* `%in%` is contained in
* `>` is greater than
* `>=` is greater than or equal to


